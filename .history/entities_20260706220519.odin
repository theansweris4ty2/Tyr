package Tyr
import rl "vendor:raylib"

TILE_WIDTH :: 50
TILE_HEIGHT :: 50

Board:: [dynamic]Tile
Tile:: struct {
    rect: rl.Rectangle,
    kind: string, 
    texture: rl.Texture,
    production_value: i32,
    harvested: bool,
    occupied: bool,
    invaded: bool,
    border: struct {color: rl.Color, thickness: f32}
}

Player::struct {
    action_points1: i32,
    action_points2: i32,
    action_points3: i32,
    score: i32,
    ore: i32, 
    lumber: i32,
    soldiers: i32,
    crops: i32,
}

Troop_Tile::struct {
    rect.
}