package main

import rl "vendor:raylib"
import "core:fmt"


WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {
rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
player: Player = {}
p_ptr: ^Player = &player
water := rl.LoadTexture("assets/water.png")
ore := rl.LoadTexture("assets/ore.png")
wheat := rl.LoadTexture("assets/wheat.png")
forest := rl.LoadTexture("assets/tree.png")
defer rl.UnloadTexture(forest)
defer rl.UnloadTexture(ore)
defer rl.UnloadTexture(wheat)
defer rl.UnloadTexture(water)
x: f32
y: f32
tile_map:= generate_map(wheat, water, forest, ore)
defer delete(tile_map)
// buttons1, main_menu, stats_menu := create_ui()


for !rl.WindowShouldClose(){
    point := rl.GetMousePosition()
    rl.BeginDrawing()
    rl.ClearBackground(rl.WHITE)
    player_action(tile_map, p_ptr)

draw_map(tile_map)
for button in buttons1 {
    rl.DrawRectangle(i32(button.rect.x), i32(button.rect.y), i32(button.rect.width), i32(button.rect.height), rl.RED)
}
// rl.DrawRectangleLines(i32(stats_menu.rect.x), i32(stats_menu.rect.y), i32(stats_menu.rect.width), i32(stats_menu.rect.height), rl.RED)


rl.EndDrawing()
}

rl.CloseWindow()
}