package main

import k2 "vendor:karl2d"

WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {
k2.init(WINDOW_WIDTH, WINDOW_HEIGHT, "Map Maker")
for k2.update(){
k2.clear(k2.WHITE)
k2.present()
}
k2.shut()

}