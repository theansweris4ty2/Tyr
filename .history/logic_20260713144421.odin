package Tyr
import "core:fmt"
import "core:math/rand"
import "core:strings"
import rl "vendor:raylib"


roll_dice :: proc() -> (i32, i32, i32){
    roll1:= rand.int32_range(0,6) 
    roll2 := rand.int32_range(0,6) 
    roll3 := rand.int32_range(0,6) 

    return roll1, roll2, roll3
}


taxation :: proc(player_ptr: ^Player, rate: i32){
    player_ptr.treasury += rate * player_ptr.territory
}

// TODO: Add logic for these player actions


/*
war :: proc(player_ptr: ^Player, index: i32){

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

produce :: proc(tile: ^Tile, player: ^Player){
    if !tile.harvested{
    switch tile.kind {
        case "farm":
            player^.grain += tile.production_value
        case "forest":
            player^.lumber += tile.production_value
        case "ore":
            player^.ore += tile.production_value 
    }
    tile.harvested = true
}

}
// TODO: Try to change main proc so that player action is only triggered when an action is taken - could add if statement - this might reduce the 
player_action :: proc(tile_map: [dynamic]Tile, player_ptr: ^Player, point: rl.Vector2, action: string, town_texture: rl.Texture2D, menu: bool, infantry: rl.Texture, crossbowmen: rl.Texture, cavalry: rl.Texture, unit: string){
    
   
    for &tile, i in tile_map {
    if rl.IsMouseButtonPressed(.LEFT) && rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width, tile.rect.height}) && !menu{
        switch action {
            case "produce":
                 produce(&tile, player_ptr)
            case "build":
                tile.texture = town_texture
            case "spy":
                fmt.printf("%s: %d, tile number: %d \n invaded: %v \n", tile.kind, tile.production_value, i, tile.invaded)
  
            case "move":
                for &troop in player_ptr.troops {
                    if troop.unit_type == unit && !troop.moved{
                        troop.rect.x = tile.rect.x
                        troop.rect.y = tile.rect.y
                        troop.moved = true
                        break
                    }
                }

        }
    }

        }    
    }  
    

generate_map::proc(texture: rl.Texture, water: rl.Texture, forest: rl.Texture, ore: rl.Texture) -> [dynamic]Tile
{
    game_board: [dynamic]Tile
    invaded: bool
        for j in 0..<1512{
            x:= f32(j % 42) * 50
            y:= f32(j/42) * 50 + 50
            production_value := rand.int32_range(1,5)
            invasion := rand.int32_range(1, 100)
            switch invasion {
                case 1..=25:
                    invaded= true
                case 26..=100:
                    invaded = false  
            }
            append(&game_board, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "farm", texture, production_value, false, false, invaded, {rl.BLACK, 1}})
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
        x = f32(i % 12)*100 + 20
        y = f32(i/12) *75 + 100
        
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

camera_movement :: proc(camera: ^rl.Camera2D, map_screen: bool) -> rl.Vector2{
    if map_screen {
    if rl.IsKeyDown(.RIGHT){
        if camera.target.x < 980{
            camera.target.x += 2
        }
    } if rl.IsKeyDown(.LEFT){
        if camera.target.x > 80 {
            camera.target.x -= 2
        }
    }
     if rl.IsKeyDown(.DOWN){
        if camera.target.y < 1140 {
        camera.target.y += 2
        }
    }
     if rl.IsKeyDown(.UP){
        if camera.target.y > 60 {
        camera.target.y -= 2
        }
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

draw_ui :: proc(buttons_array:.. [dynamic; 20]Button){
    for buttons in buttons_array {
        for button in buttons{
        
        rl.DrawRectangleRounded({button.rect.x, button.rect.y, button.rect.width, button.rect.height},1, 1, button.color)
        rl.DrawText(button.label, i32(button.rect.x + button.x_text_offset), i32(button.rect.y +10), 30, BRICK)
    }
}

}

load_assets :: proc()-> (rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Texture2D, rl.Music) {
water := rl.LoadTexture("assets/water.png")
ore := rl.LoadTexture("assets/mountains.png")
wheat := rl.LoadTexture("assets/wheat.png")
forest := rl.LoadTexture("assets/trees.png")
castle := rl.LoadTexture("assets/castle.png")
town := rl.LoadTexture("assets/town.png")
battlefield1 := rl.LoadTexture("assets/battlefield1.png")
battlefield2 := rl.LoadTexture("assets/battlefield2.png")
battlefield3 := rl.LoadTexture("assets/battlefield3.png")
battlefield4 := rl.LoadTexture("assets/battlefield4.png")
infantry:= rl.LoadTexture("assets/infantry.png")
crossbowmen:= rl.LoadTexture("assets/crossbowmen.png")
cavalry:= rl.LoadTexture("assets/cavalry.png")
background:= rl.LoadTexture("assets/start_screen.png")
opening_song := rl.LoadMusicStream("assets/light-ambience.mp3")


return water, ore, wheat, forest, castle, town, battlefield1, battlefield2, battlefield3, battlefield4, infantry, crossbowmen, cavalry, background, opening_song
}

unload_textures :: proc (textures: ..rl.Texture2D) {
    for texture in textures {
        rl.UnloadTexture(texture)
    }
}
unload_sounds :: proc (sounds: ..rl.Music){
    for sound in sounds {
        rl.UnloadMusicStream(sound)
    }
   
}

print_player_stats :: proc(player_ptr: ^Player){

player_stats:= fmt.tprintf("Grain: %d Lumber: %d Ore: %d Soldiers: %d Treasury: %d", player_ptr.grain, player_ptr.lumber, player_ptr.ore, len(player_ptr.troops), player_ptr.treasury)
b:= strings.builder_make()
fmt.sbprintf(&b, player_stats)
rl.DrawText(strings.to_cstring(&b), 10, 20, 40, rl.BLACK)

}
