package main

import rl "vendor:raylib"
import "core:fmt"

WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {


rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
background := rl.LoadTexture("assets/background.png")
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

for !rl.WindowShoulClose(){
    rl.BeginDraw
}
for k2.update(){
k2.clear(k2.WHITE)
k2.draw_texture(background, 0,0)

for tile in tile_map {
    x = tile.x
    y = tile.y
    k2.draw_texture(wheat, x, y)
    x = 0 
    y = 0
}



k2.present()
}
k2.shutdown()


}
