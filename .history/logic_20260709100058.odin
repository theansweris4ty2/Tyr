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

recruit :: proc(player_ptr: ^Player){
    troop:= Troop_Tile{}
    append(&player_ptr.troops, troop)
    player_ptr.treasury -= troop.recruitment_cost

}

taxation :: proc(player_ptr: ^Player, rate: i32){
    player_ptr.treasury += rate * player_ptr.territory
}

// TODO: Add logic for these player actions

/* move :: proc(player_ptr: ^Player, index: i32) {
 }

war :: proc(player_ptr: ^Player, index: i32){

}

build :: proc(player_ptr: ^Player){

}

spy :: proc(player_ptr: ^Player){

}
*/
sell_goods :: proc(player_ptr: ^Player, goods: string, amount: i32, market: Market){

    player_ptr.treasury += market[goods] * amount
}

buy_goods :: proc(player_ptr: ^Player, goods: string, amount: i32, market: Market){

    player_ptr.treasury -= market[goods] * amount
    switch goods {
        case "grain":
            player_ptr.grain += amount
        case "ore": 
            player_ptr.ore += amount
        case "lumber":
            player_ptr.lumber += amount
    }
}

produce :: proc(tile: Tile, player: ^Player){

    switch tile.kind {
        case "farm":
            player^.grain += tile.production_value
        case "forest":
            player^.lumber += tile.production_value
        case "ore":
            player^.ore += tile.production_value
        
    }

}
/* TODO: Add UI for player action choices and then separate it out into different actions listed below alter the logic in the current player action proc for other purposes, e.g. spy
*/
player_action :: proc(texture: rl.Texture, texture2: rl.Texture, tile_map: [dynamic]Tile, player_ptr: ^Player, point: rl.Vector2){
    
   
    for &tile, i in tile_map {
    if rl.IsMouseButtonPressed(.LEFT) && rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width, tile.rect.height}){
        tile.texture = texture
        // tile.border = {rl.RED, 3}
        produce(tile, player_ptr)
        fmt.printf("grain: %d \n Lumber: %d \n Ore: %d \n", player_ptr.grain, player_ptr.lumber, player_ptr.ore)
       
        
    }  
    // TODO: Add logic to print this information to screen and change to IsMouseButtonDown
    if rl.IsMouseButtonPressed(.RIGHT) && rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width - 10, tile.rect.height - 10}){
        fmt.printf("%s: %d, tile number: %d \n", tile.kind, tile.production_value, i)
        tile.texture = texture2

    }  
}
}

generate_map::proc(texture: rl.Texture, water: rl.Texture, forest: rl.Texture, ore: rl.Texture) -> [dynamic]Tile
{
    game_board: [dynamic]Tile
    
        for j in 0..<1008 {
            x:= f32(j % 36) * 50
            y:= f32(j/36) * 50
            production_value := rand.int32_range(1,5)
            append(&game_board, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "farm", texture, production_value, false, false, false, {rl.BLACK, 1}})
        }

    water_tiles: [dynamic;100]Tile
    forest_tiles: [dynamic; 60]Tile
    ore_tiles: [dynamic; 60]Tile

    for i in 0..<60{
        x:= rand.float32_range(0, 36) *50
        y:= rand.float32_range(0, 30) *50
        append(&water_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "water", water, 0, false, false, false, {rl.BLACK, 1}})
    }
    for i in 0..<40 {
        x:= rand.float32_range(0, 36) * 50
        y:= rand.float32_range(0, 30) * 50
         append(&forest_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "forest", forest, 0, false, false, false, {rl.BLACK, 1}})   
    }
    for i in 0..<40 {
        x:= rand.float32_range(0, 36) * 50
        y:= rand.float32_range(0, 30) * 50
        append(&ore_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "ore", ore, 0, false, false, false, {rl.BLACK, 1}})    
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
 
    rl.DrawTexture(tile.texture, i32(tile.rect.x), i32(tile.rect.y), rl.WHITE)
    rl.DrawRectangleLinesEx(tile.rect, tile.border.thickness, tile.border.color)

}
}

build_battle_board :: proc(texture1: rl.Texture, texture2: rl.Texture, texture3: rl.Texture, texture4: rl.Texture) -> [dynamic]Tile{
    tiles : [dynamic]Tile
    
    x: f32
    y: f32
    for i in 0..<84{
        x = f32(i % 12)*100 
        y = f32(i/12) *75 + 200
        
            append(&tiles, Tile{{x, y, 100, 75}, "battle", {}, 0,false, false, false, {rl.BLACK, 1}})
        
    }
    
   for &tile in tiles {
        terrain := rand.int_range(1,10)
        switch terrain {
            case 1..=3:
                tile.texture = texture1
            case 4..=5: 
                tile.texture = texture2
            case 6: 
                tile.texture = texture3
            case 7..=9:
                tile.texture = texture4
        }
    
}
return tiles
}

camera_movement :: proc(camera: ^rl.Camera2D) -> rl.Vector2{
    if rl.IsKeyDown(.RIGHT){
        if camera.target.x < 920{
            camera.target.x += 2
        }
    } if rl.IsKeyDown(.LEFT){
        if camera.target.x > 80 {
            camera.target.x -= 2
        }
    }
     if rl.IsKeyDown(.DOWN){
        if camera.target.y < 760 {
        camera.target.y += 2
        }
    }
     if rl.IsKeyDown(.UP){
        if camera.target.y > 80 {
        camera.target.y -= 2
        }
    }
    point := rl.GetScreenToWorld2D(rl.GetMousePosition(), camera^)
    return point
}

events :: proc(market: Market, game_map: ^[dynamic]Tile) {
    rebellion := rand.int32_range(0, 100)
    invasion := rand.int32_range(0, 100)
    for good, &price in market {
        price *= 2
    }
}

draw_ui :: proc(buttons:[3]Button, tool_bar: Tool_Bar){
    for button in buttons {
        rl.DrawText("TYR", 400, 300, 100, BRICK)
        rl.DrawRectangleRounded({button.rect.x, button.rect.y, button.rect.width, button.rect.height},1, 1, button.color)
        rl.DrawText(button.label, i32(button.rect.x + button.x_text_offset), i32(button.rect.y +10), 30, BRICK)
    }

}

