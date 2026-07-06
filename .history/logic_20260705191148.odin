package Tyr
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"


roll_dice :: proc() -> (i32, i32, i32){
    roll1:= rand.int32_range(0,6) 
    roll2 := rand.int32_range(0,6) 
    roll3 := rand.int32_range(0,6) 

    return roll1, roll2, roll3
}

produce :: proc(tile: Tile, player: ^Player){

    switch tile.kind {
        case "farm":
            player^.crops += tile.production_value
        case "forest":
            player^.lumber += tile.production_value
        case "ore":
            player^.ore += tile.production_value
        
    }

}

player_action :: proc(tile_map: [dynamic]Tile, player_ptr: ^Player){
    point:= rl.GetMousePosition()
    for &tile in tile_map {
    if rl.IsMouseButtonPressed(.LEFT) && rl.CheckCollisionPointRec(point, tile.rect){
        tile.border = {rl.RED, 3}
        produce(tile, player_ptr)
        fmt.printf("Crops: %d \n Lumber: %d \n Ore: %d \n", player_ptr.crops, player_ptr.lumber, player_ptr.ore)
    }  
    // TODO: Add logic to print this information to screen and change to IsMouseButtonDown
    if rl.IsMouseButtonPressed(.RIGHT) && rl.CheckCollisionPointRec(point, tile.rect){
        
        fmt.printf("%s: %d", tile.kind, tile.production_value)

    }  
}
}

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

    for i in 0..<30{
        x:= rand.float32_range(0, 1200) 
        y:= rand.float32_range(0, 900) 
        append(&water_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "water", water, 0, false, false, false, {}})
    }
    for i in 0..<20 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
         append(&forest_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "forest", forest, 0, false, false, false, {}})
        
    }
    for i in 0..<20 {
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
draw_map::proc(tile_map: [dynamic]Tile){
     for &tile in tile_map {
    
    x := tile.rect.x
    y := tile.rect.y
 
    rl.DrawTexture(tile.texture, i32(x), i32(y), rl.WHITE)
    rl.DrawRectangleLinesEx(tile.rect, tile.border.thickness, tile.border.color)

}
}

build_board :: proc() -> [dynamic]Tile{
    tiles : [dynamic]Tile
    start_y: f32 = 500
    start_x: f32 = 300
    x: f32
    y: f32
    for i in 0..=4{
        x = f32(i*100) + 350
        for h in 0..=i {
            y = f32(h*100) + start_y
            append(&tiles, Tile{"", k2.Rect{x, y, 100, 100}, " ", 0,  {}, false, false, false})
        }
        start_y -= 50
        start_x += 50
    }
    start_y = 250
    columns: int = 5
    for i in 0..=5{
        x = f32(i*100) + f32(850) 
        for h in 0..=columns{
            y = f32(h*100) + start_y
            append(&tiles, Tile{"", k2.Rect{x, y, 100, 100}, " ", 0,  {}, false, false, false})
        }
        start_y += 50
        columns -= 1   
    }
    for &tile in tiles {
        tile.production_value = rand.int32_range(1, 5)
        tile_variant := rand.int32_range(0,4)
        switch tile_variant {
            case 0: 
                tile.kind = "farm"
                tile.product = "wheat"
                tile.texture = k2.load_texture_from_file("assets/wheatSquare.png")
            case 1:
                tile.kind = "forest"
                tile.product = "lumber"
                tile.texture = k2.load_texture_from_file("assets/woodSquare.png")
            case 2: 
                tile.kind = "mine"
                tile.product = "ore"
                tile.texture = k2.load_texture_from_file("assets/oreSquare.png")
            case 3: 
                tile.kind = "military"
                tile.product = "recruits"
                tile.texture = k2.load_texture_from_file("assets/militarySquare.png")

        }
    }
    return tiles
}

draw_board::proc(tiles:[dynamic]Tile){
    for tile in tiles {
        tile_border: rl.Color
        if tile.occupied == true{
            tile_border = rl.BLUE
        }
        else if tile.invaded == true {
            tile_border = rl.RED
        }
        else { tile_border = rl.BLACK
        }
    // rl.DrawTexture(tile.texture, {tile.rect.x, tile.rect.y})
    rl.DrawRectangleLines(tile.rect, 3, rl.BLACK)
} 
}