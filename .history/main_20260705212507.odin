package Tyr

import rl "vendor:raylib"
import "core:fmt"


WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {
rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
player: Player = {}
p_ptr: ^Player = &player
water := rl.LoadTexture("assets/water.png")
ore := rl.LoadTexture("assets/mountains.png")
wheat := rl.LoadTexture("assets/wheat.png")
forest := rl.LoadTexture("assets/trees.png")
castle := rl.LoadTexture("assets/castle.png")
town := rl.LoadTexture("assets/town.png")
battlefield := rl.LoadTexture("assets/battlefield.png")
battlefield2 := rl.LoadTexture("assets/battlefield.png")
defer rl.UnloadTexture(battlefield)
defer rl.UnloadTexture(battlefield)
defer rl.UnloadTexture(town)
defer rl.UnloadTexture(forest)
defer rl.UnloadTexture(ore)
defer rl.UnloadTexture(wheat)
defer rl.UnloadTexture(water)
defer rl.UnloadTexture(castle)
tile_map:= generate_map(wheat, water, forest, ore)
defer delete(tile_map)
battle_map := battle_board(battlefield, battlefield2)
battle_screen: bool


for !rl.WindowShouldClose(){
    point := rl.GetMousePosition()
    rl.BeginDrawing()
    rl.ClearBackground(rl.WHITE)
    player_action(castle, town, tile_map, p_ptr)

if rl.IsKeyPressed(.B){
    battle_screen = true
}
if battle_screen{
draw_board(battle_map)
}
else {
    draw_map(tile_map)
}




rl.EndDrawing()
}

rl.CloseWindow()
}