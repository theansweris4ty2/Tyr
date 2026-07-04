package main
import k2 "vendor:karl2d"
import "core:math/rand"

Vec2 :: [2]f32
Tile:: struct {
    coord: Vec2,
    rect: k2.Rect,
    kind: string, 
}

seed :: proc() -> [dynamic]Tile{
tile_map : [dynamic]Tile

for i in 0..=9 {
    x: i32
    y: i32 
    x = rand.int32_range(10, 1000)
    y = rand.int32_range(10, 800)


}


return tile_map
}