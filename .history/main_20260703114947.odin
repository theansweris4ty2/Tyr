package main

import k2 "vendor:karl2d"
import "core:fmt"

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
defer k2.destroy_texture(wheat)
core_tiles := seed(ore, wheat, forest)
defer delete(core_tiles)
tile_map := spread(core_tiles)
// tile_map := generate_map(wheat)
// defer delete(tile_map)

for k2.update(){
k2.clear(k2.WHITE)
k2.draw_texture(background, 0,0)
// fmt.println(tile_map)
// for tile in tile_map {
//     k2.draw_texture(tile.texture, tile.rect.x, tile.rect.y)
// }


k2.present()
}
k2.shutdown()


}
