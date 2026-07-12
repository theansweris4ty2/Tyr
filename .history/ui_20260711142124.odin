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


Toolbar :: struct {
    rect: rl.Rectangle,
    buttons: [3]Button,
}


Menu :: struct {
    rect: rl.Rectangle,
    buttons: [3]Button,
}









