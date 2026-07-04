package main

import rl "vendor:raylib"
import "core:fmt"


WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {


rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
water := rl.LoadTexture("assets/waterSquare.png")
ore := rl.LoadTexture("assets/oreSquare.png")
wheat := rl.LoadTexture("assets/wheatSquare.png")
forest := rl.LoadTexture("assets/woodSquare.png")
defer rl.UnloadTexture(forest)
defer rl.UnloadTexture(ore)
defer rl.UnloadTexture(wheat)
x: f32
y: f32
tile_map:= generate_map(wheat)
defer delete(tile_map)
water_tiles, forest_tiles, ore_tiles := seed_tiles(water, forest, ore)

for !rl.WindowShouldClose(){
    rl.BeginDrawing()
    rl.ClearBackground(rl.WHITE)
    for tile in tile_map {
        for water_tile in water_tiles {
            if rl.CheckColisionRecs(tile.rect, water_tile.rect){
                tile.kind = "water"
            }
        }
    }
    for tile in tile_map {
    x = tile.rect.x
    y = tile.rect.y
    rl.DrawTexture(wheat, i32(x), i32(y), rl.WHITE)
}
rl.EndDrawing()
}

rl.CloseWindow()
}