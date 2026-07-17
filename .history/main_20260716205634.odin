package Tyr

import rl "vendor:raylib"
import "core:fmt"
import "core:slice"



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
p_ptr.treasury = 100
defer free(p_ptr)
defer delete(p_ptr.troops)
market := make(Market)
market["Grain"] = 1
market["Lumber"] = 1
market["Ore"] = 1
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
menu : bool
action: string
unit: string
camera := rl.Camera2D{{100,70}, {100, 70}, 0, 1.25}
rl.PlayMusicStream(opening_song)


for !rl.WindowShouldClose(){
    rl.BeginDrawing()
    rl.ClearBackground(BRICK)
    rl.BeginMode2D(camera)
    point:= camera_movement(&camera, map_screen)

    
// Try to refactor to combine menu into a single proc in the logic file
    
    if rl.IsKeyPressed(.M){
        if !menu {
            menu = true
            action = ""
        } else {
            menu = false
        } 
    }

    if menu {
    
   for button in menu1.buttons {
    point := rl.GetMousePosition()
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "Main Menu":
                        start_screen = true
                        menu = false
                        battle_screen = false
                        map_screen = false
                    case "Battle":
                        battle_screen = true
                        start_screen = false
                        map_screen = false
                    case "Produce":
                        action = "produce"
                    case "Recruit":
                        action = "recruit" 
                    case "Build":
                        action = "build"
                    case "Spy":
                        action = "spy"
                    case "Move":
                        action = "move"
                    case "Tax":
                        action = "tax"
                        taxation(p_ptr, 1)
                    
                        case "Quit":
                        rl.CloseWindow()
                }
            }
        }
}
    if action == "recruit"{
        troop: Troop_Tile
        point := rl.GetMousePosition()
        for button in menu1.buttons {
        if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
            switch button.label {
        case "Infantry":
            troop.texture = infantry
            troop.recruitment_cost = 2
            troop.troop_size = 1
            troop.unit_type = "infantry"
            troop.movement = 2
             if p_ptr.treasury >= troop.recruitment_cost{
            append(&p_ptr.troops, troop)
            p_ptr.treasury -= troop.recruitment_cost
            }
        case "Crossbow":
            troop.texture = crossbowmen
            troop.recruitment_cost = 4
            troop.troop_size = 1
            troop.unit_type = "crossbow"
            troop.movement = 3
            if p_ptr.treasury >= troop.recruitment_cost{
            append(&p_ptr.troops, troop)
            p_ptr.treasury -= troop.recruitment_cost
            }
        case "Cavalry":
            troop.texture = cavalry
            troop.recruitment_cost = 6
            troop.troop_size = 1
            troop.unit_type = "cavalry"
            troop.movement = 5
            if p_ptr.treasury >= troop.recruitment_cost{
            append(&p_ptr.troops, troop)
            p_ptr.treasury -= troop.recruitment_cost
            }
    }
        }
    }
}
    if action == "move" {
        point := rl.GetMousePosition()
        for button in menu1.buttons {
        if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
            switch button.label {
                case "Infantry":
                    unit = "infantry"
                case "Crossbow":
                    unit = "crossbow"
                case "Cavalry":
                    unit = "cavalry"
        }
    }
}
    }
    
    if start_screen {
        battle_screen = false
        map_screen = false
        rl.DrawTexture(background, 0,0, WHEAT_GOLD)
        rl.DrawText("TYR", 500, 300, 100, BRICK)
        draw_ui(menu, start_buttons)
        rl.UpdateMusicStream(opening_song)
        camera.target.x = 100
        camera.target.y = 100
        for button in start_buttons {
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "New Game":
                        camera.target.x = 100
                        camera.target.y = 50
                        map_screen = true
                        battle_screen = false
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
        player_action(tile_map, p_ptr, point, action, town, menu, infantry, crossbowmen, cavalry, unit)
        for tile in tile_map {
        if tile.invaded && tile.occupied {
        menu = false
        battle_screen = true
        start_screen = false
        map_screen = false
        menu = false
    }
}
       
    }
// TODO: Need to add logic that only allows you to place troops that player has in his army - look at language in the move proc in the logic file

if battle_screen{
    troop_type := [3]rl.Texture2D {infantry, crossbowmen, cavalry}
    start_screen = false
    map_screen = false
    draw_map(battle_map)
    draw_ui (menu, battle_buttons)
    camera.target.x = 100
    camera.target.y = 100
    for button in battle_buttons {
            if rl.CheckCollisionPointRec(point, button.rect) && rl.IsMouseButtonPressed(.LEFT){
                switch button.label {
                    case "Infantry":
                        active_troops = 0
                       
                    case "Crossbow":
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
        if rl.IsMouseButtonPressed(.LEFT){
            if rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width -10, tile.rect.height - 10}) {
            append(&troop_tiles, Troop_Tile{{tile.rect.x, tile.rect.y, 50, 75}, troop_type[active_troops], 10, 1, "infantry", 2, false})
        }
    }
    
}

}

rl.EndMode2D()
if menu {
   draw_ui(menu, menu1.buttons)
}


if !start_screen {
    print_player_stats(p_ptr)
}

rl.EndDrawing()

}

rl.CloseWindow()

}
