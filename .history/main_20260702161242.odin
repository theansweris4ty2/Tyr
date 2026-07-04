package main

import k2 "vendor:karl2d"
import "core:fmt"

WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {


k2.init(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
water := k2.load_texture_from_file("assets/waterSquare.png")
wheat := k2.load_texture_from_file("assets/wheatSquare.png")
forest := k2.load_texture_from_file("assets/woodSquare.png")
defer k2.destroy_texture(forest)
defer k2.destroy_texture(water)
defer k2.destroy_texture(wheat)
water_tiles, farm_tiles, forest_tiles := seed(water, wheat, forest)
tile_map := spread(farm_tiles, forest_tiles, water_tiles)
defer delete(tile_map)
terrain_tiles := build_map(tile_map)
defer delete(terrain_tiles)
// for tile in terrain_tiles {
//     append(&tile_map, tile)
// }

for k2.update(){
k2.clear(k2.WHITE)
for tile in tile_map {
    
    k2.draw_texture(tile.texture, {tile.rect.x, tile.rect.y})
    
}
for tile in terrain_tiles {
    kr.draw_texture
}

k2.present()
}
k2.shutdown()


}
