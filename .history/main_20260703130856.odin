package main

import rl "vendor:raylib"
import "core:fmt"
import k2 "vendor:karl2d"

WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {


k2.init(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
background := k2.load_texture_from_file("assets/background.png")
ore := k2.load_texture_from_file("assets/oreSquare.png")
wheat := k2.load_texture_from_file("assets/wheatSquare.png")
forest := k2.load_texture_from_file("assets/woodSquare.png")
defer k2.destroy_texture(forest)
defer k2.destroy_texture(ore)
defer k2.destroy_(wheat)
x: f32
y: f32
tile_map:= generate_map(wheat)
defer delete(tile_map)

for !rl.WindowShouldClose(){
    rl.BeginDrawing()
    rl.ClearBackground(rl.WHITE)
    for tile in tile_map {
    x = tile.rect.x
    y = tile.rect.y
    rl.DrawTexture(wheat, i32(x), i32(y), rl.WHITE)
}
rl.EndDrawing()
}

rl.CloseWindow()
}