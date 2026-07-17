package Tyr
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

SLATE :: rl.Color {123, 111, 131, 170}
BRICK :: rl.Color{156, 67, 0, 255}
OCEAN_BLUE :: rl.Color{79, 166, 235, 255}
FOREST_GREEN :: rl.Color{81, 125, 25, 255}
WHEAT_GOLD :: rl.Color{255, 220, 115, 200}
KHAKI :: rl.Color{150, 119, 63, 255}

Button :: struct {
    rect: rl.Rectangle,
    color: rl.Color,
    label: cstring,
    x_text_offset: f32
}

Menu :: struct {
    rect: rl.Rectangle,
    buttons: [dynamic; 20]Button,
}


start_buttons: [dynamic; 20]Button = {Button{{500, 400, 200, 50}, WHEAT_GOLD, "New Game", 30}, Button{{500, 475, 200, 50}, WHEAT_GOLD, "Saved Game", 10}, Button{{500, 550, 200, 50}, WHEAT_GOLD, "Quit", 75}}
menu1_rect: rl.Rectangle = {200, 200, 800, 900}
menu_buttons: [dynamic; 20]Button = {Button{{menu1_rect.x + 10, menu1_rect.y + 10, 200, 50}, WHEAT_GOLD, "Main Menu", 30}, Button{{menu1_rect.x + 10, menu1_rect.y + 70, 200, 50}, WHEAT_GOLD, "Battle", 50}, Button{{menu1_rect.x + 10, menu1_rect.y + 130, 200, 50}, WHEAT_GOLD, "Quit", 75}, Button{{menu1_rect.x + 10, menu1_rect.y + 190, 200, 50}, WHEAT_GOLD, "Produce", 50}, Button{{menu1_rect.x + 10, menu1_rect.y + 250, 200, 50}, WHEAT_GOLD, "Spy", 50}, Button{{menu1_rect.x + 10, menu1_rect.y + 310, 200, 50}, WHEAT_GOLD, "Build", 50}, Button{{menu1_rect.x + 10, menu1_rect.y + 370, 200, 50}, WHEAT_GOLD, "Tax", 50},  Button{{menu1_rect.x + 190, menu1_rect.y + 430, 200, 50}, WHEAT_GOLD, "Move", 50}, Button{{menu1_rect.x + 400, menu1_rect.y + 430, 200, 50}, WHEAT_GOLD, "Recruit", 50}, Button{{menu1_rect.x + 80, menu1_rect.y + 500, 200, 50}, WHEAT_GOLD, "Infantry", 40}, Button{{menu1_rect.x + 290, menu1_rect.y + 500, 200, 50}, WHEAT_GOLD, "Crossbow", 30}, Button{{menu1_rect.x + 500, menu1_rect.y + 500, 200, 50}, WHEAT_GOLD, "Cavalry", 40}, Button{{menu1_rect.x + 190, menu1_rect.y + 570, 200, 50}, WHEAT_GOLD, "Buy", 50}, Button{{menu1_rect.x + 400, menu1_rect.y + 10, 200, 50}, WHEAT_GOLD, "Sell", 50}, Button{{menu1_rect.x + 80, menu1_rect.y + 70, 200, 50}, WHEAT_GOLD, "Grain", 40}, Button{{menu1_rect.x + 290, menu1_rect.y + 70, 200, 50}, WHEAT_GOLD, "Lumber", 30}, Button{{menu1_rect.x + 500, menu1_rect.y + 70, 200, 50}, WHEAT_GOLD, "Ore", 40}}
menu1: Menu = {menu1_rect, menu_buttons}
/* TODO: Add buttons to battle_buttons for additional battle actions including placement of troops which should fix issue with accidental placement. 
*/
battle_buttons: [dynamic; 20]Button = {Button{{300, 655, 200, 50}, WHEAT_GOLD, "Infantry", 30}, Button{{520, 655, 200, 50}, WHEAT_GOLD, "Crossbow", 30}, Button{{740, 655, 200, 50}, WHEAT_GOLD, "Cavalry", 30}}











