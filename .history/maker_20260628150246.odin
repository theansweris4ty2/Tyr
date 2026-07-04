package main
import k2 "vendor:karl2d"
import "core:math/rand"

water := k2.load_texture_from_file("assets/")


Vec2 :: [2]f32
Tile:: struct {
    rect: k2.Rect,
    kind: string, 
    texture: k2.Texture
}

seed :: proc() -> [dynamic]Tile{
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
    append(&water, Tile{{x, y, 100, 100}, "water"})


}


return tile_map
}