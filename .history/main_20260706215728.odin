package Tyr

import rl "vendor:raylib"
import "core:fmt"


WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {
rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Tyr")
player: Player = {}
p_ptr: ^Player = &player
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
tile_map:= generate_map(wheat, water, forest, ore)
defer delete(tile_map)
battle_map := build_battle_board(battlefield1, battlefield2, battlefield3, battlefield4)
defer delete(battle_map)
battle_screen: bool


for !rl.WindowShouldClose(){
    rl.BeginDrawing()
    rl.ClearBackground(rl.BEIGE)
    player_action(castle, town, tile_map, p_ptr)

if rl.IsKeyPressed(.B){
    if !battle_screen {
    battle_screen = true
    }
    else {
        battle_screen = false
    }
}
if battle_screen{
draw_battle_board(battle_map)
for &tile in battle_map {
    point := rl.GetMousePosition()
    if rl.IsMouseButtonPressed(.LEFT) {
        if CheckColli
    }
    
}
}
else {
    draw_map(tile_map)
}



rl.EndDrawing()
}

rl.CloseWindow()
}