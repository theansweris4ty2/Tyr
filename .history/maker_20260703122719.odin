package main
import k2 "vendor:karl2d"
import "core:math/rand"
import "core:fmt"


x_velocity: f32 = 5
y_velocity: f32 = 5
TILE_WIDTH :: 50
TILE_HEIGHT :: 50

Board:: [dynamic]Tile

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
       
        return collided
    }

generate_map::proc() -> [dynamic]Vec2
{
    game_board: [dynamic]Vec2

    // // for i in 0..<18{
    //     x: f32
    //     y: f32
    //     for j in 0..<24{
    //     x = f32(0) 
    //     y = f32(j) * 50
    

    //     append(&game_board, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "farm", texture, 0,0})
    // // }
    for i in 0..<18 {
        for j in 0..<24 {
            x:= f32(j * 50)
            y:= f32(i) * 50
            append(&game_board,Vec2 {x, y})
        }
    }

    return game_board
}



