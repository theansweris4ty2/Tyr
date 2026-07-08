package Tyr

import rl "vendor:raylib"
import "core:fmt"


WINDOW_WIDTH :: 1200
WINDOW_HEIGHT :: 900

main :: proc() {
rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Tyr")
troop_tiles: [dynamic]Troop_Tile
defer delete(troop_tiles)
p_ptr := new(Player)
defer free(p_ptr)
defer delete(p_ptr.troops)

water := rl.LoadTexture("assets/water.png")
ore := rl.LoadTexture("assets/mountains.png")
wheat := rl.LoadTexture("assets/wheat.png")
forest := rl.LoadTexture("assets/trees.png")
castle := rl.LoadTexture("assets/castle.png")
town := rl.LoadTexture("assets/town.png")
battlefield1 := rl.LoadTexture("assets/battlefield1.png")
battlefield2 := rl.LoadTexture("assets/battlefield2.png")
battlefield3 := rl.LoadTexture("assets/battlefield3.png")
battlefield4 := rl.LoadTexture("assets/battlefield4.png")
infantry:= rl.LoadTexture("assets/crossbowmen.png")
defer rl.UnloadTexture(infantry)
defer rl.UnloadTexture(battlefield1)
defer rl.UnloadTexture(battlefield2)
defer rl.UnloadTexture(battlefield3)
defer rl.UnloadTexture(battlefield4)
defer rl.UnloadTexture(town)
defer rl.UnloadTexture(forest)
defer rl.UnloadTexture(ore)
defer rl.UnloadTexture(wheat)
defer rl.UnloadTexture(water)
defer rl.UnloadTexture(castle)
tile_map:= generate_map(wheat, water, forest, ore)
defer delete(tile_map)
battle_map := build_battle_board(battlefield1, battlefield2, battlefield3, battlefield4)
defer delete(battle_map)
battle_screen: bool
camera := rl.Camera2D{{0,0}, {0, 0}, 0, 1.25}


for !rl.WindowShouldClose(){
    rl.BeginDrawing()
    rl.ClearBackground(rl.BEIGE)
    rl.BeginMode2D(camera)
   
    if !battle_screen {
         player_action(castle, town, tile_map, p_ptr, camera)
    }

    if rl.IsKeyDown(.RIGHT){
        camera.target.x += 1
    } if rl.IsKeyDown(.LEFT){
        camera.target.x -= 1
    }
     if rl.IsKeyDown(.DOWN){
        camera.target.y += 1
    }
     if rl.IsKeyDown(.UP){
        camera.target.y -= 1
    }
    if rl.IsKeyPressed(.B){
    if !battle_screen {
    battle_screen = true
    }
    else {
        battle_screen = false
    }
}
if battle_screen{
    draw_map(battle_map)
    for tile in troop_tiles {
        rl.DrawTexture(tile.texture, i32(tile.rect.x), i32(tile.rect.y), rl.WHITE)
    }
    for &tile in battle_map {
        point := rl.GetMousePosition()
        if rl.IsMouseButtonPressed(.LEFT) {
            if rl.CheckCollisionPointRec(point, {tile.rect.x, tile.rect.y,tile.rect.width - 10, tile.rect.height - 10}) {
            append(&troop_tiles, Troop_Tile{{tile.rect.x, tile.rect.y, 50, 75}, infantry})
        }
    }
    
}
}
else {
    draw_map(tile_map)
}


rl.EndMode2D()
rl.EndDrawing()

}

rl.CloseWindow()
}