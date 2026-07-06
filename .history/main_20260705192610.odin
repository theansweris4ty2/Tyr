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
ore := rl.LoadTexture("assets/mountains2.png")
wheat := rl.LoadTexture("assets/wheat.png")
forest := rl.LoadTexture("assets/trees.png")
defer rl.UnloadTexture(forest)
defer rl.UnloadTexture(ore)
defer rl.UnloadTexture(wheat)
defer rl.UnloadTexture(water)
x: f32
y: f32
tile_map:= generate_map(wheat, water, forest, ore)
defer delete(tile_map)
battle_map := build_board(wheat)
battle_screen: bool


for !rl.WindowShouldClose(){
    point := rl.GetMousePosition()
    rl.BeginDrawing()
    rl.ClearBackground(rl.WHITE)
    player_action(tile_map, p_ptr)
if !battle
draw_map(tile_map)



rl.EndDrawing()
}

rl.CloseWindow()
}