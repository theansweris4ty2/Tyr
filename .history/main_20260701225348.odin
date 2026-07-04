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
for k2.update(){
k2.clear(k2.WHITE)
for tile in tile_map {
    tile.rect..x +=
    for i in 0..=len(tile_map) -2 {
        if tile_map[i].rect.x + tile_map[i].rect.w >= tile_map[i+1].rect.x && tile_map[i].rect.x <= tile_map[i+1].rect.x + tile_map[1+1].rect.w && tile_map[i].rect.y + tile_map[i].rect.h >= tile_map[i+1].rect.y && tile_map[i].rect.y <= tile_map[i+1].rect.y + tile_map[i+1].rect.h  {
            tile_map[i].x_velocity *= -1
            tile_map[i].y_velocity *= -1
            tile_map[i+1].y_velocity *= -1
            tile_map[i+1].x_velocity *= -1
            
   
    }
}
    k2.draw_texture(tile.texture, {tile.rect.x, tile.rect.y})
    
}

k2.present()
}
k2.shutdown()


}
