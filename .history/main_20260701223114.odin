package main

import k2 "vendor:karl2d"
import "core:fmt"

WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {


k2.init(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
tile_map := spread()
defer delete(tile_map)
for k2.update(){
k2.clear(k2.WHITE)
for tile in tile_map {
    k2.draw_texture(tile.texture, {tile.rect.x, tile.rect.y})
}

k2.present()
}
k2.shutdown()


}
