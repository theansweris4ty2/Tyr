package 
import "core:fmt"
import "core:math/rand"
import k2 "vendor:karl2d"





// TODO add logic for building UI either in the build_board proc or as a separate proc. 
build_board :: proc() -> [dynamic]Tile{
    tiles : [dynamic]Tile
    start_y: f32 = 500
    start_x: f32 = 300
    x: f32
    y: f32
    for i in 0..=4{
        x = f32(i*100) + 350
        for h in 0..=i {
            y = f32(h*100) + start_y
            append(&tiles, Tile{"", k2.Rect{x, y, 100, 100}, " ", 0,  {}, false, false, false})
        }
        start_y -= 50
        start_x += 50
    }
    start_y = 250
    columns: int = 5
    for i in 0..=5{
        x = f32(i*100) + f32(850) 
        for h in 0..=columns{
            y = f32(h*100) + start_y
            append(&tiles, Tile{"", k2.Rect{x, y, 100, 100}, " ", 0,  {}, false, false, false})
        }
        start_y += 50
        columns -= 1   
    }
    for &tile in tiles {
        tile.production_value = rand.int32_range(1, 5)
        tile_variant := rand.int32_range(0,4)
        switch tile_variant {
            case 0: 
                tile.kind = "farm"
                tile.product = "wheat"
                tile.texture = k2.load_texture_from_file("assets/wheatSquare.png")
            case 1:
                tile.kind = "forest"
                tile.product = "lumber"
                tile.texture = k2.load_texture_from_file("assets/woodSquare.png")
            case 2: 
                tile.kind = "mine"
                tile.product = "ore"
                tile.texture = k2.load_texture_from_file("assets/oreSquare.png")
            case 3: 
                tile.kind = "military"
                tile.product = "recruits"
                tile.texture = k2.load_texture_from_file("assets/militarySquare.png")

        }
    }
    return tiles
}

draw_board::proc(tiles:[dynamic]Tile){
    for tile in tiles {
        tile_border: k2.Color
        if tile.occupied == true{
            tile_border = k2.BLUE
        }
        else if tile.invaded == true {
            tile_border = k2.RED
        }
        else { tile_border = k2.BLACK
        }
    k2.draw_texture(tile.texture, {tile.rect.x, tile.rect.y})
    k2.draw_rect_outline(tile.rect, 3, tile_border)
} 
}

check_collisions :: proc(rect: k2.Rect, point: Vec2)-> bool{
        collided: bool
        if point.x  > rect.x && point.x  < rect.x + rect.w && point.y > rect.y && point.y  < rect.y + rect.h {
            collided = true
        }
        else {
            collided = false
        }
        return collided
    }
    
load_game_textures ::proc(dice: [6]string) -> [dynamic; 6]k2.Texture{
    dice_images: [dynamic; 6]k2.Texture
    for string in dice {
        image := k2.load_texture_from_file(string, {})
        append(&dice_images, image)
    }
    return dice_images
}

roll_dice :: proc() -> (i32, i32, i32){
    roll1:= rand.int32_range(0,6) 
    roll2 := rand.int32_range(0,6) 
    roll3 := rand.int32_range(0,6) 

    return roll1, roll2, roll3
}

produce :: proc(tile: Tile, player: ^Player){

    switch tile.kind {
        case "farm":
            player^.crops += tile.production_value
        case "forest":
            player^.lumber += tile.production_value
        case "mine":
            player^.ore += tile.production_value
        case "military":
            player^.troops += tile.production_value
    }

}

player_action :: proc(tiles: [dynamic]Tile, player_ptr: ^Player, buttons1: [dynamic; 6]Button, point: [2]f32){
    dice1_index: i32 = 0
    dice2_index :i32 = 0
    dice3_index :i32 = 0
    if k2.mouse_button_went_down(.Left) {
        for &tile in tiles {
            if check_collisions(tile.rect, point){
                if player_ptr.action_points1 > 0 && !tile.harvested && !tile.invaded{
                    player_ptr.action_points1 -= 1
                    tile.occupied = true
                    produce(tile, player_ptr)
                    tile.harvested = true   
                
            } 
            else if player_ptr.action_points2 > 0 && !tile.harvested &&!tile.invaded{
                player_ptr.action_points2 -= 1

                tile.occupied = true
                produce(tile, player_ptr)
                tile.harvested = true
            }
            else if player_ptr.action_points3 > 0 && !tile.harvested && !tile.invaded{
                player_ptr.action_points3 -= 1
                tile.occupied = true
                produce(tile, player_ptr)
                tile.harvested = true   

            }

        }
    }

    
}

if k2.mouse_button_is_held(.Right) {
    for tile in tiles {
        if check_collisions(tile.rect, point){
            k2.draw_text(tile.kind, {f32(50), f32(300)}, 40, k2.BLACK)
            k2.draw_text(fmt.tprintf("{}", tile.production_value), {f32(60), f32(350)}, 40, k2.BLACK)
            
        }
        
    }
}

}
invasion_check :: proc()-> bool{
    invasion: bool
    switch rand.int32_range(0, 10){
        case 0..=5:
            invasion = true
        case 6..=10:
            invasion = false
    }
    return invasion
}

invade_tile :: proc(tiles: [dynamic]Tile){
    invaded := rand.int_range(0, len(tiles) - 1)
    tiles[invaded].invaded = true


}