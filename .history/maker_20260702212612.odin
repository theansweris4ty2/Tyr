package main
import k2 "vendor:karl2d"
import "core:math/rand"
import "core:fmt"


x_velocity: f32 = 5
y_velocity: f32 = 5
TILE_WIDTH :: 50
TILE_HEIGHT :: 50

Vec2 :: [2]f32
Tile:: struct {
    rect: k2.Rect,
    kind: string, 
    texture: k2.Texture,
    x_velocity: f32, 
    y_velocity: f32
}

check_collisions :: proc(rect: k2.Rect, rect2: k2.Rect)-> bool{
        collided: bool
        if rect2.x + rect2.w > rect.x && rect2.x  < rect.x + rect.w && rect2.y + rect2.h > rect.y && rect2.y  < rect.y + rect.h {
            collided = true
        }
        else {
            collided = false
        }
        return collided
    }

seed :: proc(texture: k2.Texture, texture2: k2.Texture, texture3: k2.Texture) -> [dynamic]Tile{

x: f32
y: f32
core_tiles: [dynamic]Tile

 for i in 0..<10 {
    x = rand.float32_range(0, 1600)
    y = rand.float32_range(0, 1000)
 
    append(&core_tiles, Tile{{x, y, f32(50), f32(50)}, "ore", texture, 0, 0})
}
 for i in 0..<10 {
    x = rand.float32_range(0, 1600) 
    y = rand.float32_range(0, 1000) 
    append(&core_tiles, Tile{{x, y, f32(50), f32(50)}, "farm", texture2, 0, 0})
    
 }
 for i in 0..<10 {
    x = rand.float32_range(200, 1600)
    y = rand.float32_range(200, 1000)
    append(&core_tiles, Tile{{x, y, f32(50), f32(50)}, "forest", texture3, 0, 0})
 }

for &tile, i in core_tiles{
    
    for tile in core_tiles{
        if check_collisions(tile.rect, core_tiles[i].rect){
            // unordered_remove(&core_tiles, i)
            core_tiles[i].rect.x += core_tiles[i].rect.w
        }      
    }

// pop(&core_tiles)
}
return core_tiles
}

spread :: proc(core_tiles: [dynamic]Tile) -> [dynamic]Tile{
tile_map : [dynamic]Tile
terrain_tiles :[dynamic; 300]Tile

for i in 0..<300 {
    x := rand.float32_range(0, 1600) 
    y := rand.float32_range(0, 1000) 
    append(&terrain_tiles, Tile{{x, y, TILE_WIDTH, TILE_HEIGHT}, "", {}, 0, 0})
    
 }

for &tile in core_tiles {
    append(&tile_map, tile)
}

for tile in tile_map{
    
    for terrain_tile in terrain_tiles{
        if check_collisions(tile.rect, terrain_tile.rect){
            // append(&tile_map, Tile{{terrain_tile.rect.x, terrain_tile.rect.y, terrainrect.w, rect.h}, tile.kind, tile.texture, 0, 0}  )
            fmt.println("hit")
        }      
    }
}


return tile_map
}


   
