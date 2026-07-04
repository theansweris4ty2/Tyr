package main

import k2 "vendor:karl2d"
import "core:fmt"

WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {


k2.init(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
water := k2.load_texture_from_file("assets/waterSquare.png")
wheat := k2.load_texture_from_file("assets/wheatSquare.png")
water_tiles, fam := seed(water, farm)
for k2.update(){
k2.clear(k2.WHITE)
for tile in water_tiles {
    k2.draw_texture(tile.texture, {tile.rect.x, tile.rect.y})
}
k2.present()
}
k2.shutdown()


}
