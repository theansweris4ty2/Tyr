package main
import k2 "vendor:karl2d"
import "core:math/rand"
import "core:fmt"


x_velocity: f32 = 5
y_velocity: f32 = 5
TILE_WIDTH :: 50
TILE_HEIGHT :: 50

Vec2 :: [2]f32
Tile:: struct {
    rect: k2.Rect,
    kind: string, 
    texture: k2.Texture,
    x_velocity: f32, 
    y_velocity: f32
}

check_collisions :: proc(rect: k2.Rect, rect2: k2.Rect)-> bool{
        collided: bool
        if rect2.x + rect2.w > rect.x && rect2.x  < rect.x + rect.w && rect2.y + rect2.h > rect.y && rect2.y  < rect.y + rect.h {
            collided = true
        }
        else {
            collided = false
        }
        return collided
    }

seed :: proc(texture: k2.Texture, texture2: k2.Texture, texture3: k2.Texture) -> ([dynamic; 8]Tile, [dynamic; 15]Tile, [dynamic; 45]Tile){

water : [dynamic; 8]Tile 
forests : [dynamic; 45]Tile
farms: [dynamic; 15]Tile
mines: [50]Tile
military: [50]Tile
x: f32
y: f32

for i in 0..<8 {
    x = rand.float32_range(0, 1600)
    y = rand.float32_range(0, 1000)
    append(&water, Tile{{x, y, f32(100), f32(50)}, "water", texture, 0, 0})
}
 for i in 0..<15 {
    x = rand.float32_range(0, 1600) 
    y = rand.float32_range(0, 1000) 
    append(&farms, Tile{{x, y, f32(50), f32(50)}, "farm", texture2, 0, 0})
    
 }
 for i in 0..<45 {
    x = rand.float32_range(200, 1600)
    y = rand.float32_range(200, 1000)
    append(&forests, Tile{{x, y, f32(50), f32(50)}, "forest", texture3, 0, 0})
 }
 terrain_tiles :[dynamic]Tile
 defer delete(terrain_tiles)
    for i in 0..<500 {
    x:= rand.float32_range(0, 1150)
    y:= rand.float32_range(0,850)
    append(&terrain_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "", {}, x_velocity , y_velocity})
}
// for i in 0..<500 {   
    for terrain_tile in terrain_tiles{
        // terrain_tile.rect.x += terrain_tile.x_velocity
        //  terrain_tile.rect.y += terrain_tile.y_velocity
        //  fmt.println(terrain_tiles[10].rect.x, terrain_tiles[10].x_velocity, terrain_tiles[10].y_velocity
        // )
        //  if terrain_tile.rect.y <= 0 || terrain_tile.rect.y + terrain_tile.rect.h >= 900 {
        //      terrain_tile.y_velocity *= -1
        //  }
        //  if terrain_tile.rect.x <= 0 || terrain_tile.rect.x + terrain_tile.rect.w >= 1200 {
        //      terrain_tile.x_velocity *= -1
        //  }
         for tile in water {
            if check_collisions(tile.rect, terrain_tile.rect){
                append(&water, Tile{{terrain_tile.rect.x, terrai,"water", texture, 0, 0 })
                // terrain_tile.kind = tile.kind
                // terrain_tile.texture = tile.texture
                // terrain_tile.x_velocity = 0
                // terrain_tile.y_velocity = 0
            }
        }
        for tile in farms {
            if check_collisions(tile.rect, terrain_tile.rect){
                append(&water, Tile{terrain_tile.rect,"farm", texture2, 0, 0 })
                // terrain_tile.kind = tile.kind
                // terrain_tile.texture = tile.texture
                // terrain_tile.x_velocity = 0
                // terrain_tile.y_velocity = 0
            }
        }
        for tile in forests {
            if check_collisions(tile.rect, terrain_tile.rect){
                append(&water, Tile{terrain_tile.rect,"forest", texture3, 0, 0 })
                // terrain_tile.kind = tile.kind
                // terrain_tile.texture = tile.texture
                // terrain_tile.x_velocity = 0
                // terrain_tile.y_velocity = 0
            }
        }
        // }
        
    }
return water, farms, forests
}

spread :: proc(farm_tiles: [dynamic; 15]Tile, forest_tiles:[dynamic; 45]Tile, water_tiles: [dynamic; 8]Tile) -> [dynamic]Tile{
tile_map : [dynamic]Tile



for tile in forest_tiles {
    append(&tile_map, tile)
}
for tile in water_tiles {
    append(&tile_map, tile)
}
for tile in farm_tiles {
    append(&tile_map, tile)
}


for &tile, i in tile_map{
    
    for tile in tile_map{
        if check_collisions(tile.rect, tile_map[i].rect){
            unordered_remove(&tile_map, i)
        }      
    }
}

return tile_map
}


   
