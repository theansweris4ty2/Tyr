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

seed :: proc(texture: k2.Texture, texture2: k2.Texture, texture3: k2.Texture) -> ([dynamic; 5]Tile, [dynamic; 5]Tile, [dynamic; 5]Tile){
tile_map : [dynamic]Tile
water : [dynamic; 5]Tile 
forests : [dynamic; 5]Tile
farms: [dynamic; 5]Tile
mines: [50]Tile
military: [50]Tile
x: f32
y: f32

for i in 0..<5 {
    x = rand.float32_range(10, 1500)
    y = rand.float32_range(10, 800)
    append(&water, Tile{{x, y, f32(100), f32(100)}, "water", texture, 5, 5})
}
 for i in 0..<5 {
    x = rand.float32_range(10, 1500) 
    y = rand.float32_range(100, 800) 
    append(&farms, Tile{{x, y, f32(100), f32(100)}, "farm", texture2, 5, 5})
    
 }
 for i in 0..<5 {
    x = rand.float32_range(10, 1500)
    y = rand.float32_range(10, 800)
    append(&forests, Tile{{x, y, f32(100), f32(100)}, "forest", texture3, 5, 5})
 }


return water, farms, forests
}

spread :: proc() -> [dynamic]Tile{
tile_map: [dynamic]Tile
water := k2.load_texture_from_file("assets/waterSquare.png")
wheat := k2.load_texture_from_file("assets/wheatSquare.png")
forest := k2.load_texture_from_file("assets/woodSquare.png")
water_tiles, farm_tiles, forest_tiles := seed(water, wheat, forest)

for i in 0..<10 {

    for &tile in farm_tiles {
        tile.rect.x += tile.x_velocity
        tile.rect.y += tile.y_velocity
    //     for &next_tile in farm_tiles {
    //     if tile.rect.x + tile.rect.w >= next_tile.rect.x && tile.rect.x <= next_tile.rect.x + next_tile.rect.w && tile.rect.y + tile.rect.h >= next_tile.rect.y && tile.rect.y <= next_tile.rect.y + next_tile.rect.h {
    //         tile.x_velocity = 0
    //         tile.y_velocity = 0
    //         next_tile.y_velocity = 0
    //         next_tile.x_velocity = 0
    //     }
    // }
}
}
for &tile in forest_tiles {
    tile.rect.x += tile.x_velocity
    tile.rect.y += tile.y_velocity
    // for &next_tile in farm_tiles {
    //     if tile.rect.x + tile.rect.w >= next_tile.rect.x && tile.rect.x <= next_tile.rect.x + next_tile.rect.w && tile.rect.y + tile.rect.h >= next_tile.rect.y && tile.rect.y <= next_tile.rect.y + next_tile.rect.h {
    //         tile.x_velocity = 0
    //         tile.y_velocity = 0
    //         next_tile.y_velocity = 0
    //         next_tile.x_velocity = 0
    //     }
    // }
}
for &tile in water_tiles {
    tile.rect.x += tile.x_velocity
    tile.rect.y += tile.y_velocity
    // for &next_tile in farm_tiles {
    //     if tile.rect.x + tile.rect.w >= next_tile.rect.x && tile.rect.x <= next_tile.rect.x + next_tile.rect.w && tile.rect.y + tile.rect.h >= next_tile.rect.y && tile.rect.y <= next_tile.rect.y + next_tile.rect.h {
    //         tile.x_velocity = 0
    //         tile.y_velocity = 0
    //         next_tile.y_velocity = 0
    //         next_tile.x_velocity = 0
    //     }
    // }
}

// for tile in forest_tiles {
//     append(&tile_map, tile)
// }
// for tile in water_tiles {
//     append(&tile_map, tile)
// }
for tile in farm_tiles {
    append(&tile_map, tile)
}
for tile in forest_tiles {
    append(&tile_map, tile)
}
for tile in water_tiles {
    append(&tile_map, tile)
}

for &tile in tile_map{
    for i in 0..=len(tile_map) -2 {
        if i.rect.x + i.rect.w >= tile_map[i+1].rect.x && tile_map[i+1].rect.x <= next_tile.rect.x + next_tile.rect.w && tile.rect.y + tile.rect.h >= next_tile.rect.y && tile.rect.y <= next_tile.rect.y + next_tile.rect.h {
    // //         tile.x_velocity = 0
    // //         tile.y_velocity = 0
    // //         next_tile.y_velocity = 0
    // //         next_tile.x_velocity = 0
    // //     }
    // // }
    // }
}
return tile_map
}