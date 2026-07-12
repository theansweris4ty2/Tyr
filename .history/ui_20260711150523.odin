package Tyr
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

SLATE :: rl.Color {123, 111, 131, 255}
BRICK :: rl.Color{156, 67, 0, 255}
OCEAN_BLUE :: rl.Color{79, 166, 235, 255}
FOREST_GREEN :: rl.Color{81, 125, 25, 255}
WHEAT_GOLD :: rl.Color{255, 220, 115, 200}

Button :: struct {
    rect: rl.Rectangle,
    color: rl.Color,
    label: cstring,
    x_text_offset: f32
}

Menu :: struct {
    rect: rl.Rectangle,
    buttons: [3]Button,
}


start_buttons: [3]Button = {Button{{500, 400, 200, 50}, WHEAT_GOLD, "New Game", 30}, Button{{500, 475, 200, 50}, WHEAT_GOLD, "Saved Game", 10}, Button{{500, 550, 200, 50}, WHEAT_GOLD, "Quit", 75}}
menu1: Menu = {{200, 200, 400, 400}, menu_buttons}
menu_buttons: [3]Button = {Button{{500, 400, 200, 50}, WHEAT_GOLD, "New Game", 30}, Button{{500, 475, 200, 50}, WHEAT_GOLD, "Saved Game", 10}, Button{{500, 550, 200, 50}, WHEAT_GOLD, "Quit", 75}}
map_buttons: [3]Button = {Button{{300, 0, 200, 50}, WHEAT_GOLD, "Main Menu", 30}, Button{{520, 0, 200, 50}, WHEAT_GOLD, "Battle", 50}, Button{{740, 0, 200, 50}, WHEAT_GOLD, "Quit", 75}}
battle_buttons: [3]Button = {Button{{300, 655, 200, 50}, WHEAT_GOLD, "Infantry", 30}, Button{{520, 655, 200, 50}, WHEAT_GOLD, "Crossbow", 30}, Button{{740, 655, 200, 50}, WHEAT_GOLD, "Cavalry", 30}}






