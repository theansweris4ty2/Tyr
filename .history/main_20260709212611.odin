package Tyr

import rl "vendor:raylib"
import "core:fmt"



WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {
rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Tyr")
rl.InitAudioDevice()
rl.SetTargetFPS(120)
troop_tiles: [dynamic]Troop_Tile
defer delete(troop_tiles)
p_ptr := new(Player)
defer free(p_ptr)
defer delete(p_ptr.troops)
market := make(Market)
defer delete(market)

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
defer rl.UnloadTexture(background)
defer rl.UnloadTexture(infantry)
defer rl.UnloadTexture(crossbowmen)
defer rl.UnloadTexture(cavalry)
defer rl.UnloadTexture(battlefield1)
defer rl.UnloadTexture(battlefield2)
defer rl.UnloadTexture(battlefield3)
defer rl.UnloadTexture(battlefield4)
defer rl.UnloadTexture(town)
defer rl.UnloadTexture(forest)
defer rl.UnloadTexture(ore)
defer rl.UnloadTexture(wheat)
defer rl.UnloadTexture(water)
defer rl.UnloadTexture(castle)
opening_song := rl.LoadMusicStream("assets/light-ambience.mp3")
defer rl.UnloadMusicStream(opening_song)
tile_map:= generate_map(wheat, water, forest, ore)
defer delete(tile_map)
battle_map := build_battle_board(battlefield1, battlefield2, battlefield3, battlefield4)
defer delete(battle_map)
battle_screen: bool
start_screen : = true
map_screen : bool
camera := rl.Camera2D{{100,100}, {100, 100}, 0, 1.25}
buttons: [3]Button = {Button{{400, 400, 200, 50}, WHEAT_GOLD, "New Game", 30}, Button{{400, 475, 200, 50}, WHEAT_GOLD, "Saved Game", 10}, Button{{400, 550, 200, 50}, WHEAT_GOLD, "Quit", 75}}
toolbar: Toolbar = {{0, 0, WINDOW_WIDTH, 50}, {Button{{200, 0, 200, 50}, WHEAT_GOLD, "Main Menu", 30}, Button{{420, 0, 200, 50}, WHEAT_GOLD, "Battle", 50}, Button{{640, 0, 200, 50}, WHEAT_GOLD, "Quit", 75}}}
toolbar2: Toolbar = {{0, 650, WINDOW_WIDTH, 50}, {Button{{200, 650, 200, 50}, WHEAT_GOLD, "Infantry", 10}, Button{{420, 650, 200, 50}, WHEAT_GOLD, "Crossbowmen", 10}, Button{{640, 650, 200, 50}, WHEAT_GOLD, "Cavalry", 10}}}
rl.PlayMusicStream(opening_song)


for !rl.WindowShouldClose(){
    rl.BeginDrawing()
    rl.ClearBackground(WHEAT_GOLD)
    rl.BeginMode2D(camera)
    point:= camera_movement(&camera)
    


    if start_screen {
        battle_screen = false
        map_screen = false
        rl.DrawTexture(background, 0,0, WHEAT_GOLD)
        draw_ui(buttons)
        rl.UpdateMusicStream(opening_song)
        camera.target.x = 100
        camera.target.y = 200
        for button in buttons {
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "New Game":
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
        player_action(castle, town, tile_map, p_ptr, point)
        draw_map(tile_map)
        draw_toolbar(toolbar)
        for button in toolbar.buttons {
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
       
    }

if battle_screen{
    troop_type := map[string]rl.Texture2D {
        "infantry": infantry,
        "crossbowmen": crossbow
    }
    start_screen = false
    map_screen = false
    draw_map(battle_map)
    draw_toolbar(toolbar)
    draw_toolbar(toolbar2)
    camera.target.x = 100
    camera.target.y = 50
    camera.zoom = 1
     for button in toolbar.buttons {
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
    for button in toolbar2.buttons {
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "Infantry":
                        active_troops := infantry
                    case "Crossbowmen":
                        active_troops := crossbowmen
                    case "Cavalry":
                        active_troops := cavalry
                    case:
                        active_troops := infantry
                }
            }
        }
    for tile in troop_tiles {
        rl.DrawTexture(tile.texture, i32(tile.rect.x), i32(tile.rect.y), rl.WHITE)
    }
    for &tile in battle_map {
        if rl.IsMouseButtonPressed(.LEFT) {
            if rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width -10, tile.rect.height - 10}) {
            append(&troop_tiles, Troop_Tile{{tile.rect.x, tile.rect.y, 50, 75}, active_troops, 10, 1, "infantry", 2})
        }
    }
    
}

}


rl.EndMode2D()
rl.EndDrawing()

}

rl.CloseWindow()
}