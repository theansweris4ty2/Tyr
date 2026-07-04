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

for i in 0..9 {

}
water : [10]Tile 
forests : [50]Tile
farms: [50]Tile
mines: [50]Tile
military: [50]Tile

return tile_map
}