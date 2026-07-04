package main
import "core:math/rand"
import "core:fmt"
import rl "vendor:raylib"


x_velocity: f32 = 5
y_velocity: f32 = 5
TILE_WIDTH :: 50
TILE_HEIGHT :: 50

Board:: [dynamic]Tile

Vec2 :: [2]f32
Tile:: struct {
    rect: rl.Rectangle,
    kind: string, 
    texture: rl.Texture,
    x_velocity: f32, 
    y_velocity: f32
}





generate_map::proc(texture: rl.Texture) -> [dynamic]Tile
{
    game_board: [dynamic]Tile

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
            x:= f32(j 24) * 50
            y:= f32(i/24) * 50
            append(&game_board, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "farm", texture, 0,0})
        }
    }

    return game_board
}



