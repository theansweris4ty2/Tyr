package Tyr

import rl "vendor:raylib"
import "core:fmt"



WINDOW_WIDTH :: 1500
WINDOW_HEIGHT :: 1000

main :: proc() {
rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Tyr")
rl.InitAudioDevice()
rl.SetTargetFPS(120)
troop_tiles: [dynamic]Troop_Tile
active_troops: i32
defer delete(troop_tiles)
p_ptr := new(Player)
defer free(p_ptr)
defer delete(p_ptr.troops)
market := make(Market)
defer delete(market)
water, ore, wheat, forest, castle, town, battlefield1, battlefield2, battlefield3, battlefield4, infantry, crossbowmen, cavalry, background, opening_song := load_assets()
defer unload_textures(water, ore, wheat, forest, castle, town, battlefield1, battlefield2, battlefield3, battlefield4, infantry, crossbowmen, cavalry, background)
defer unload_sounds(opening_song)
tile_map:= generate_map(wheat, water, forest, ore)
defer delete(tile_map)
battle_map := build_battle_board(battlefield1, battlefield2, battlefield3, battlefield4)
defer delete(battle_map)
battle_screen: bool
start_screen : = true
map_screen : bool
camera := rl.Camera2D{{100,100}, {100, 100}, 0, 1.25}
menu1: Menu = {{200, 200, 400, 400}}
start_buttons: [3]Button = {Button{{400, 400, 200, 50}, WHEAT_GOLD, "New Game", 30}, Button{{400, 475, 200, 50}, WHEAT_GOLD, "Saved Game", 10}, Button{{400, 550, 200, 50}, WHEAT_GOLD, "Quit", 75}}
map_buttons: [3]Button = {Button{{300, 0, 200, 50}, WHEAT_GOLD, "Main Menu", 30}, Button{{520, 0, 200, 50}, WHEAT_GOLD, "Battle", 50}, Button{{740, 0, 200, 50}, WHEAT_GOLD, "Quit", 75}}
battle_buttons: [3]Button = {Button{{300, 655, 200, 50}, WHEAT_GOLD, "Infantry", 30}, Button{{520, 655, 200, 50}, WHEAT_GOLD, "Crossbow", 30}, Button{{740, 655, 200, 50}, WHEAT_GOLD, "Cavalry", 30}}
rl.PlayMusicStream(opening_song)


for !rl.WindowShouldClose(){
    rl.BeginDrawing()
    rl.ClearBackground(WHEAT_GOLD)
    rl.BeginMode2D(camera)
    point:= camera_movement(&camera, map_screen)
    


    if start_screen {
        battle_screen = false
        map_screen = false
        rl.DrawTexture(background, 0,0, WHEAT_GOLD)
        draw_ui(start_buttons)
        rl.UpdateMusicStream(opening_song)
        
        for button in start_buttons {
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "New Game":
                        camera.target.x = 100
                        camera.target.y = 50
                        map_screen = true
                    case "Saved Game":
                        fmt.println("Saved Game")
                    case "Quit":
                        rl.CloseWindow()
                }
            }
        }

       
    }
    
    if map_screen {
        start_screen = false
        battle_screen = false
        draw_map(tile_map)
        draw_ui(map_buttons)
        for button in map_buttons {
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "Main Menu":
                        start_screen = true
                    case "Battle":
                        battle_screen = true
                    case "Quit":
                        rl.CloseWindow()
                }
            }
        }
        player_action(castle, town, tile_map, p_ptr, point)
       
    }

if battle_screen{
    troop_type := [3]rl.Texture2D {infantry, crossbowmen, cavalry}
    start_screen = false
    map_screen = false
    draw_map(battle_map)
    draw_ui (map_buttons, battle_buttons)
     for button in map_buttons {
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "Main Menu":
                        start_screen = true
                    case "Map":
                        map_screen = true
                    case "Quit":
                        rl.CloseWindow()
                }
            }
        }
    for button in battle_buttons {
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "Infantry":
                        active_troops = 0
                       
                    case "Crossbowmen":
                        active_troops = 1
                      
                    case "Cavalry":
                        active_troops = 2
                       
                    }
                    }
        }
    for tile in troop_tiles {
        rl.DrawTexture(tile.texture, i32(tile.rect.x), i32(tile.rect.y), rl.WHITE)
    }
    for &tile in battle_map {
        if rl.IsMouseButtonPressed(.LEFT) {
            if rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width -10, tile.rect.height - 10}) {
            append(&troop_tiles, Troop_Tile{{tile.rect.x, tile.rect.y, 50, 75}, troop_type[active_troops], 10, 1, "infantry", 2})
        }
    }
    
}

}


rl.EndMode2D()
rl.EndDrawing()

}

rl.CloseWindow()
}
