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
x: f32
y: f32
tile_map:= generate_map(wheat)
defer delete(tile_map)
water_tiles, forest_tiles, ore_tiles := seed_tiles(water, forest, ore)
buttons1, main_menu, stats_menu := create_ui()
for &tile in tile_map {
        
        
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

for !rl.WindowShouldClose(){
    point := rl.GetMousePosition()
    rl.BeginDrawing()
    rl.ClearBackground(rl.WHITE)
    player_action(tile_map, p_ptr)
    for &tile in tile_map {
    
    x = tile.rect.x
    y = tile.rect.y
 
    rl.DrawTexture(tile.texture, i32(x), i32(y), rl.WHITE)
    rl.DrawRectangleLinesEx(tile.rect, tile.border.thickness, tile.border.color)

}
for button in buttons1 {
    rl.DrawRectangle(i32(button.rect.x), i32(button.rect.y), i32(button.rect.width), i32(button.rect.height), rl.RED)
}
// rl.DrawRectangleLines(i32(stats_menu.rect.x), i32(stats_menu.rect.y), i32(stats_menu.rect.width), i32(stats_menu.rect.height), rl.RED)


rl.EndDrawing()
}

rl.CloseWindow()
}