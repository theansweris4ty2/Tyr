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


return water, farms, forests
}

spread :: proc(farm_tiles: [dynamic; 15]Tile, forest_tiles:[dynamic; 45]Tile, water_tiles: [dynamic; 8]Tile) -> [dynamic]Tile{
tile_map : [dynamic]Tile
core_tiles :[dynamic]Tile
defer delete(core_tiles)



for tile in forest_tiles {
    append(&core_tiles, tile)
}
for tile in water_tiles {
    append(&core_tiles, tile)
}
for tile in farm_tiles {
    append(&core_tiles, tile)
}



for &tile in core_tiles {
    append(&tile_map, tile)
}


    
for &tile, i in tile_map{
    
    for tile in tile_map{
        if check_collisions(tile.rect, tile_map[i].rect){
            unordered_remove(&tile_map, i)
        }      
    }
}

//     for &tile in terrain_tiles {
//         tile.rect.x += tile.x_velocity
//         tile.rect.y += tile.y_velocity
//         if tile.rect.y <= 0 || tile.rect.y + tile.rect.h >= 900 {
//             tile.y_velocity *= -1
//         }
//         if tile.rect.x <= 0 || tile.rect.x + tile.rect.w >= 1200 {
//             tile.x_velocity *= -1
//         }
        f
//     }
// }
    



return tile_map
}

build_map :: proc(tile_map: [dynamic]Tile) ->[dynamic]Tile {
    terrain_tiles :[dynamic]Tile
    defer delete(terrain_tiles)
    for i in 0..<100 {
    x:= rand.float32_range(0, 1150)
    y:= rand.float32_range(0,850)
    append(&terrain_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "", {},x_velocity, y_velocity})
}
    for map_tile in tile_map {
            for &tile in terrain_tiles {
            if check_collisions(tile.rect, map_tile.rect) {
                tile.texture = map_tile.texture
                tile.kind = map_tile.kind
                // tile.x_velocity = 0
                // tile.y_velocity = 0
            }
        }
    }
    return terrain_tiles
}