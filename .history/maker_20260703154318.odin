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
    production_value: i32
}





generate_map::proc(texture: rl.Texture) -> [dynamic]Tile
{
    game_board: [dynamic]Tile
    
        for j in 0..<432 {
            x:= f32(j % 24) * 50
            y:= f32(j/24) * 50
            production_value := rand.int32_range(1,5)
            append(&game_board, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "farm", texture, production_value})
        }
    return game_board
}

seed_tiles::proc(texture1: rl.Texture, texture2: rl.Texture, texture3: rl.Texture) -> ([dynamic; 50]Tile, [dynamic; 30]Tile, [dynamic; 30]Tile){
    x: f32
    y: f32
    water_tiles: [dynamic;50]Tile
    forest_tiles: [dynamic; 30]Tile
    ore_tiles: [dynamic; 30]Tile

    for i in 0..<50{
        x:= rand.float32_range(0, 1200) 
        y:= rand.float32_range(0, 900) 
        append(&water_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "water", texture1, 0})
    }
    for i in 0..<30 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
         append(&forest_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "forest", texture3, 0})
        
    }
    for i in 0..<30 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
        append(&ore_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "ore", texture3, 0})
        
    }
    return water_tiles, forest_tiles, ore_tiles
}



