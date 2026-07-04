package main
import k2 "vendor:karl2d"
import "core:math/rand"
import "core:fmt"


x_velocity: f32 = 5
y_velocity: f32 = 5

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

seed :: proc(texture: k2.Texture, texture2: k2.Texture, texture3: k2.Texture) -> ([dynamic; 15]Tile, [dynamic; 15]Tile, [dynamic; 45]Tile){

water : [dynamic; 15]Tile 
forests : [dynamic; 45]Tile
farms: [dynamic; 15]Tile
mines: [50]Tile
military: [50]Tile
x: f32
y: f32

for i in 0..<15 {
    x = rand.float32_range(10, 1500)
    y = rand.float32_range(10, 800)
    append(&water, Tile{{x, y, f32(100), f32(50)}, "water", texture, 5, - 5})
}
 for i in 0..<15 {
    x = rand.float32_range(10, 1500) 
    y = rand.float32_range(100, 800) 
    append(&farms, Tile{{x, y, f32(50), f32(50)}, "farm", texture2, - 5, 5})
    
 }
 for i in 0..<45 {
    x = rand.float32_range(10, 1500)
    y = rand.float32_range(10, 800)
    append(&forests, Tile{{x, y, f32(50), f32(50)}, "forest", texture3, 5, 5})
 }


return water, farms, forests
}

spread :: proc(farm_tiles: [dynamic; 15]Tile, forest_tiles:[dynamic; 45]Tile, water_tiles: [dynamic; 15]Tile) -> [dynamic]Tile{
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
        tile.rect.x += tile.x_velocity
        tile.rect.y += tile.y_velocity
}


for &tile in core_tiles {
    append(&tile_map, tile)
}



for &tile, i in tile_map{
    for tile in tile_map{
        if check_collisions(tile.rect, tile_map[i].rect){
            unordered_remove(&tile_map, i)

        }
    // if tile_map[i].rect.x + tile_map[i].rect.w >= 1200 || tile_map[i].rect.x <= 0 ||tile_map[i].rect.y + tile_map[i].rect.h >= 900 || tile_map[i].rect.y <= 0{
        //     tile_map[i].x_velocity *= -1
        //     tile_map[i].y_velocity *= -1
            
            
   
    // }
    }
        
        
}


return tile_map
}