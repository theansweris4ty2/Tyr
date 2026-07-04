package main
import "core:fmt"
// import "core:math/rand"
import rl "vendor:raylib"







   

// roll_dice :: proc() -> (i32, i32, i32){
//     roll1:= rand.int32_range(0,6) 
//     roll2 := rand.int32_range(0,6) 
//     roll3 := rand.int32_range(0,6) 

//     return roll1, roll2, roll3
// }

produce :: proc(tile: Tile, player: ^Player){

    switch tile.kind {
        case "farm":
            player^.crops += tile.production_value
        case "forest":
            player^.lumber += tile.production_value
        case "ore":
            player^.ore += tile.production_value
        
    }

}

player_action :: proc(tile_map: [dynamic]Tile, player_ptr: ^Player){
    point:= rl.
    for &tile in tile_map {
    if rl.IsMouseButtonDown(.LEFT) && rl.CheckCollisionPointRec(point, tile.rect){
        tile.border = {rl.RED, 3}
        fmt.println(tile.production_value)
       

    }
    
}