package main
import k2 "vendor:karl2d"
import "core:math/rand"

Vec2 :: [2]f32
Tile:: struct {
    rect: k2.Rect,
    kind: string, 
}

seed :: proc() -> [dynamic]Tile{
tile_map : [dynamic]Tile
water : [dynamic; 10]Tile 
forests : [50]Tile
farms: [50]Tile
mines: [50]Tile
military: [50]Tile

for i in 0..=9 {
    x: i32
    y: i32 
    x = rand.int32_range(10, 1000)
    y = rand.int32_range(10, 800)
    append(&water, Tile{rect})


}


return tile_map
}