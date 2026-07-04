package main

import k2 "vendor:karl2d"
import "core:fmt"

WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {
water := k2.load_texture_from_file("C:?Users\mdjd2OdinProjects\map_maker\assets\waterSquare.png")
// water_tiles := seed(water)
// fmt.println(water_tiles)
// fmt.println("water_tiles")
k2.init(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
for k2.update(){
k2.clear(k2.WHITE)
// for tile in water_tiles {
//     // k2.draw_texture(tile.texture, {tile.rect.x, tile.rect.y})
//     fmt.println(tile)
// }
k2.present()
}
k2.shutdown()


}
