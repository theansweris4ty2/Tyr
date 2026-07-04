package main
import k2 "vendor:karl2d"
import "core:math/rand"
import "core:fmt"




Vec2 :: [2]f32
Tile:: struct {
    rect: k2.Rect,
    kind: string, 
    texture: k2.Texture
}

seed :: proc(texture: k2.Texture, texture2: k2.Texture, texture3: k2.Texture) -> ([dynamic; 10]Tile, [dynamic; 50]Tile, [dynamic; 50]Tile){
tile_map : [dynamic]Tile
water : [dynamic; 10]Tile 
forests : [dynamic; 50]Tile
farms: [dynamic; 50]Tile
mines: [50]Tile
military: [50]Tile

for i in 0..=9 {
    x: f32
    y: f32 
    x = rand.float32_range(10, 1000)
    y = rand.float32_range(10, 800)
    append(&water, Tile{{x, y, f32(100), f32(100)}, "water", texture})
}
 for i in 0..=49 {
    x: f32
    y: f32
    x = rand.float32_range(100, 1800) 
    y = rand.float32_range(100, 800) 
    append(&farms, Tile{{x, y, f32(100), f32(100)}, "farm", texture2})
    
 }
 for i in 0..=49 {
    
    x: = rand.float32_range(10, 1100)
    y = rand.float32_range(10, 800)
    append(&farms, Tile{{x, y, f32(100), f32(100)}, "forest", texture3})
 }



return water, farms, forests
}