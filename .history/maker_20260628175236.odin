package main
import k2 "vendor:karl2d"
import "core:math/rand"
import "core:fmt"


x_velocity: f32 = 5
y_velocity: f32 = 5

Vec2 :: [2]f32
Tile:: struct {
    rect: k2.Rect,
    kind: string, 
    texture: k2.Texture,
    x_velocity: f32, 
    y_velocity: f32
}

seed :: proc(texture: k2.Texture, texture2: k2.Texture, texture3: k2.Texture) -> ([dynamic; 10]Tile, [dynamic; 50]Tile, [dynamic; 50]Tile){
tile_map : [dynamic]Tile
water : [dynamic; 10]Tile 
forests : [dynamic; 50]Tile
farms: [dynamic; 50]Tile
mines: [50]Tile
military: [50]Tile
x: f32
y: f32

for i in 0..=9 {
    x = rand.float32_range(10, 1500)
    y = rand.float32_range(10, 800)
    append(&water, Tile{{x, y, f32(100), f32(100)}, "water", texture, 5, 5})
}
 for i in 0..=49 {
    x = rand.float32_range(10, 1500) 
    y = rand.float32_range(100, 800) 
    append(&farms, Tile{{x, y, f32(100), f32(100)}, "farm", texture2, 5, 5})
    
 }
 for i in 0..=49 {
    x = rand.float32_range(10, 1500)
    y = rand.float32_range(10, 800)
    append(&forests, Tile{{x, y, f32(100), f32(100)}, "forest", texture3, 5, 5})
 }


return water, farms, forests
}

spread :: proc(){
water := k2.load_texture_from_file("assets/waterSquare.png")
wheat := k2.load_texture_from_file("assets/wheatSquare.png")
forest := k2.load_texture_from_file("assets/woodSquare.png")
water_tiles, farm_tiles, forest_tiles := seed(water, wheat, forest)
for &tile in water_tiles {
    tile.rect.x += tile.x_velocity
    tile.rect.y += tile.y_velocity
}
for &tile in farm_tiles {
    tile.rect.x += tile.x_velocity
    tile.rect.y += tile.y_velocity
    for next_tile in farm_tiles {
        if tile.rect.x + tile.rec.
    }
}
for &tile in forest_tiles {
    tile.rect.x += tile.x_velocity
    tile.rect.y += tile.y_velocity
}
}