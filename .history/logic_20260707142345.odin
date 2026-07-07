package Tyr
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

// TODO: Write logic for battles
roll_dice :: proc() -> (i32, i32, i32){
    roll1:= rand.int32_range(0,6) 
    roll2 := rand.int32_range(0,6) 
    roll3 := rand.int32_range(0,6) 

    return roll1, roll2, roll3
}

recruit :: proc(player_ptr: ^Player){
    append(&player_ptr.troops, Troop_Tile{})
    player_ptr.treasury -= 10

}

taxation :: proc(player_ptr: ^Player, rate: i32){
    player_ptr.treasury += rate * player_ptr.territory
}

/* move :: proc(player_ptr: ^Player, index: i32) {
 }
*/

/*war :: proc(player_ptr: ^Player, index: i32){

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
// TODO: Build UI for player actions
player_action :: proc(texture: rl.Texture, texture2: rl.Texture, tile_map: [dynamic]Tile, player_ptr: ^Player){
    point:= rl.GetMousePosition()
    for &tile in tile_map {
    if rl.IsMouseButtonPressed(.LEFT) && rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width - 10, tile.rect.height - 10}){
        tile.texture = texture
        // tile.border = {rl.RED, 3}
        produce(tile, player_ptr)
        fmt.printf("Crops: %d \n Lumber: %d \n Ore: %d \n", player_ptr.crops, player_ptr.lumber, player_ptr.ore)
       
        
    }  
    // TODO: Add logic to print this information to screen and change to IsMouseButtonDown
    if rl.IsMouseButtonPressed(.RIGHT) && rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width - 10, tile.rect.height - 10}){
        fmt.printf("%s: %d", tile.kind, tile.production_value)
        tile.texture = texture2

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
            append(&game_board, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "farm", texture, production_value, false, false, false, {rl.BLACK, 1}})
        }

    water_tiles: [dynamic;50]Tile
    forest_tiles: [dynamic; 30]Tile
    ore_tiles: [dynamic; 30]Tile

    for i in 0..<30{
        x:= rand.float32_range(0, 1200) 
        y:= rand.float32_range(0, 900) 
        append(&water_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "water", water, 0, false, false, false, {rl.BLACK, 1}})
    }
    for i in 0..<20 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
         append(&forest_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "forest", forest, 0, false, false, false, {rl.BLACK, 1}})   
    }
    for i in 0..<20 {
        x:= rand.float32_range(0, 24) * 50
        y:= rand.float32_range(0, 18) * 50
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



