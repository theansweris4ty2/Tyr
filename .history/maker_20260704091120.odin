package Tyr
import "core:math/rand"
import "core:fmt"
import rl "vendor:raylib"









generate_map::proc(texture: rl.Texture, water: rl.Texture, forest: rl.Texture, ore: rl.Texture) -> [dynamic]Tile
{
    game_board: [dynamic]Tile
    
        for j in 0..<432 {
            x:= f32(j % 24) * 50
            y:= f32(j/24) * 50
            production_value := rand.int32_range(1,5)
            append(&game_board, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "farm", texture, production_value, false, false, false, {}})
        }

        x: f32
    y: f32
    water_tiles: [dynamic;50]Tile
    forest_tiles: [dynamic; 30]Tile
    ore_tiles: [dynamic; 30]Tile

    for i in 0..<50{
        x:= rand.float32_range(0, 1200) 
        y:= rand.float32_range(0, 900) 
        append(&water_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "water", water, 0, false, false, false, {}})
    }
    for i in 0..<30 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
         append(&forest_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "forest", forest, 0, false, false, false, {}})
        
    }
    for i in 0..<30 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
        append(&ore_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "ore", ore, 0, false, false, false, {}})
        
    }
    for &tile in game_board {
        
        
        for water_tile in water_tiles {
            if rl.CheckCollisionRecs(tile.rect, water_tile.rect){
                tile.kind = "water"
                tile.texture = water
            }
        for ore_tile in ore_tiles {
            if rl.CheckCollisionRecs(tile.rect, ore_tile.rect){
                tile.kind = "ore"
                tile.texture = ore
            }
    }
    for forest_tile in forest_tiles {
            if rl.CheckCollisionRecs(tile.rect, forest_tile.rect){
                tile.kind = "forest"
                tile.texture = forest
            }
        }
}
}

    return game_board
}





