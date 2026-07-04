package main
import k2 "vendor:karl2d"

Vec2 :: [2]f32
Tile:: struct {
    coord: Vec2,
    rect: k2.Rect,
    kind: string, 
}

seed :: proc() -> [dynamic]Tile{
map : []
water : [10]Tile
forests : [50]Tile
farms: [50]Tile
mines: [50]Tile
military: [50]Tile
}