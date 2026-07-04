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

draw_ui ::proc(menu: Menu, buttons: [dynamic; 6]Button, index1: i32, index2: i32, index3: i32, action1: i32, action2: i32, action3: i32, stats: Menu, player: Player){
    
    for button in menu.buttons {
    
    rl.DrawRectangle(button.rect, button.color)
    rl.DrawText(button.label, {button.rect.x + 1, button.rect.y + 10}, 30, rl.BLACK)
    rl.DrawRectangleRec_outline(button.rect, 1, rl.BLACK)
    } 
    for button in buttons {
    rl.DrawRectangleRec(button.rect, button.color)
    rl.DrawText(button.label, {button.rect.x + 10, button.rect.y + 10}, 40, rl.BLACK)
    }
    for button in stats.buttons {
        
    rl.DrawRectangleRec(button.rect, button.color)
    rl.DrawText(button.label, {button.rect.x + 10, button.rect.y + 10}, 30, rl.BLACK)
    rl.DrawRectangleRec_outline(button.rect, 1, rl.BLACK)
    }
    dice_images := load_game_textures(dice_files)
    rl.DrawTexture(dice_images[index1], {0, 700})
    rl.DrawTexture(dice_images[index2], {100, 700})
    rl.DrawTexture(dice_images[index3], {200, 700})
    rl.DrawRectangleRec_outline(menu.rect, menu.border, rl.BLACK)
    rl.DrawText(menu.label, {menu.rect.x + 50, menu.rect.y + 10}, 70, rl.BLACK)
    rl.DrawRectangleRec_outline(stats.rect, stats.border, rl.BLACK)
    rl.DrawText(stats.label, {stats.rect.x + 50, stats.rect.y + 10}, 70, rl.BLACK)
    rl.DrawText(fmt.tprintf("Action 1: {}", action1), {menu.rect.x + 50, menu.rect.y + 100}, 50, rl.BLACK)
    rl.DrawText(fmt.tprintf("Action 2: {}", action2), {menu.rect.x + 50, menu.rect.y + 150}, 50, rl.BLACK)
    rl.DrawText(fmt.tprintf("Action 3: {}", action3), {menu.rect.x + 50, menu.rect.y + 200}, 50, rl.BLACK)
    rl.DrawText(fmt.tprintf("%d", player.crops), {stats.rect.x + 200, stats.rect.y + 100}, 50, rl.BLACK)
    rl.DrawText(fmt.tprintf("%d", player.lumber), {stats.rect.x + 200, stats.rect.y + 150}, 50, rl.BLACK)
    rl.DrawText(fmt.tprintf("%d", player.ore), {stats.rect.x + 200, stats.rect.y + 200}, 50, rl.BLACK)
    rl.DrawText(fmt.tprintf("%d", player.troops), {stats.rect.x + 200, stats.rect.y + 250}, 50, rl.BLACK)

}


