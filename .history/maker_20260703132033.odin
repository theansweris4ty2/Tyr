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
    
        for j in 0..<432 {
            x:= f32(j % 24) * 50
            y:= f32(j/24) * 50
            append(&game_board, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "farm", texture, 0,0})
        }
    return game_board
}

seed_tiles::proc(){
    x: f32
    y: f32
    water_tiles: [dynamic; 10]Tile
    forest_tiles: [dynamic; 20]Tile
    ore_tiles: [dynamic; 20]Tile

    for i in 0..<9 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
    }
    for i in 0..<19 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
        
    }
    for i in 0..<19 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
        
    }
}



