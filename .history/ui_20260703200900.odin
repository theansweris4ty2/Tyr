package main
import "core:fmt"
import "core:math/rand"
import rl "vendor:karl2d"

SLATE :: rl.Color {123, 111, 131, 255}
BRICK :: rl.Color{156, 67, 0, 255}
OCEAN_BLUE :: rl.Color{79, 166, 235, 255}
FOREST_GREEN :: rl.Color{81, 125, 25, 255}
WHEAT_GOLD :: rl.Color{240, 173, 0, 255}

Button :: struct {
    rect: rl.Rect,
    color: rl.Color,
    label: string,
}


Menu :: struct {
    rect: rl.Rect,
    buttons: [dynamic; 6]Button,
    border: f32,
    label: string
}


dice_files := [6]string{"assets/pipone.png", "assets/piptwo.png", "assets/pipthree.png", "assets/pipfour.png", "assets/pipfive.png", "assets/pipsix.png"}

create_ui ::proc() -> (first_buttons: [dynamic; 6]Button, main: Menu, stats: Menu) {
    button1: Button = {{f32(100), f32(800), f32(100), f32(60)}, rl.RED, "ROLL"}
    buttons1:[dynamic; 6]Button
    buttons2: [dynamic; 6]Button
    stat_buttons: [dynamic; 6]Button
   
    append(&buttons1, button1)
    stats_menu : Menu = {{1370, 10, 420, 320}, stat_buttons, 10, "Resources"}
    main_menu: Menu = {{1370, 650, 420, 500}, buttons2, 10, "Actions"}
    
    action_button1:= Button{{main_menu.rect.x + 50, main_menu.rect.y + 300, 110, 50}, WHEAT_GOLD, "Farm"}
    action_button2:= Button{{main_menu.rect.x + 160, main_menu.rect.y + 300, 110, 50}, FOREST_GREEN, "Log"}
    action_button3:= Button{{main_menu.rect.x + 270, main_menu.rect.y + 300, 110, 50}, SLATE, "Mining"}
    action_button4:= Button{{main_menu.rect.x + 50, main_menu.rect.y + 350, 110, 50}, WHEAT_GOLD, "Research"}
    action_button5:= Button{{main_menu.rect.x + 160, main_menu.rect.y + 350, 110, 50}, FOREST_GREEN, "Trade"}
    action_button6:= Button{{main_menu.rect.x + 270, main_menu.rect.y + 350, 110, 50}, SLATE, "Build"}
    stat_button1:= Button{{stats_menu.rect.x + 50, stats_menu.rect.y + 100, 110, 50}, WHEAT_GOLD, "Crops"}
    stat_button2:= Button{{stats_menu.rect.x + 50, stats_menu.rect.y + 150, 110, 50}, FOREST_GREEN, "Lumber"}
    stat_button3:= Button{{stats_menu.rect.x + 50, stats_menu.rect.y + 200, 110, 50}, SLATE, "Ore"}
    stat_button4:= Button{{stats_menu.rect.x + 50, stats_menu.rect.y + 250, 110, 50}, BRICK, "Troops"}
    
    append(&main_menu.buttons, action_button1)
    append(&main_menu.buttons, action_button2)
    append(&main_menu.buttons, action_button3)
    append(&main_menu.buttons, action_button4)
    append(&main_menu.buttons, action_button5)
    append(&main_menu.buttons, action_button6)
    append(&stats_menu.buttons, stat_button1)
    append(&stats_menu.buttons, stat_button2)
    append(&stats_menu.buttons, stat_button3)
    append(&stats_menu.buttons, stat_button4)
    return buttons1, main_menu, stats_menu
}



}


