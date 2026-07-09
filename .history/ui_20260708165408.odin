package Tyr
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

SLATE :: rl.Color {123, 111, 131, 255}
BRICK :: rl.Color{156, 67, 0, 255}
OCEAN_BLUE :: rl.Color{79, 166, 235, 255}
FOREST_GREEN :: rl.Color{81, 125, 25, 255}
WHEAT_GOLD :: rl.Color{240, 173, 0, 255}

Button :: struct {
    rect: rl.Rectangle,
    color: rl.Color,
    label: cstring,
    x_text_offset: f32
}


Menu :: struct {
    rect: rl.Rectangle,
    buttons: [dynamic; 6]Button,
    border: f32,
    label: string
}


dice_files := [6]string{"assets/pipone.png", "assets/piptwo.png", "assets/pipthree.png", "assets/pipfour.png", "assets/pipfive.png", "assets/pipsix.png"}








