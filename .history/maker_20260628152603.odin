package main
import k2 "vendor:karl2d"
import "core:math/rand"




Vec2 :: [2]f32
Tile:: struct {
    rect: k2.Rect,
    kind: string, 
    texture: k2.Texture
}

seed :: proc(texture: k2.Texture) -> [dynamic; 10]Tile{
tile_map : [dynamic]Tile
water : [dynamic; 10]Tile 
forests : [50]Tile
farms: [50]Tile
mines: [50]Tile
military: [50]Tile

for i in 0..=9 {
    x: f32
    y: f32 
    x = rand.float32_range(10, 1000)
    y = rand.float32_range(10, 800)
    append(&water, Tile{{x, y, f32(100), f32(100}, "water", texture})

}


return water
}