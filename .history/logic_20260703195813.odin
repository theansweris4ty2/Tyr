package main
// import "core:fmt"
// import "core:math/rand"
// import rl "vendor:raylib"







   

// roll_dice :: proc() -> (i32, i32, i32){
//     roll1:= rand.int32_range(0,6) 
//     roll2 := rand.int32_range(0,6) 
//     roll3 := rand.int32_range(0,6) 

//     return roll1, roll2, roll3
// }

// produce :: proc(tile: Tile, player: ^Player){

//     switch tile.kind {
//         case "farm":
//             player^.crops += tile.production_value
//         case "forest":
//             player^.lumber += tile.production_value
//         case "ore":
//             player^.ore += tile.production_value
        
//     }

// }

// player_action :: proc(tiles: [dynamic]Tile, player_ptr: ^Player, buttons1: [dynamic; 6]Button, point: [2]f32){
//     dice1_index: i32 = 0
//     dice2_index :i32 = 0
//     dice3_index :i32 = 0
//     if rl.IsMouseButtonPressed(.LEFT) {
//         for &tile in tiles {
//             if rl.CheckCollisionPointRec(point, tile.rect){
//                 if player_ptr.action_points1 > 0 && !tile.harvested && !tile.invaded{
//                     player_ptr.action_points1 -= 1
//                     tile.occupied = true
//                     produce(tile, player_ptr)
//                     tile.harvested = true   
                
//             } 
//             else if player_ptr.action_points2 > 0 && !tile.harvested &&!tile.invaded{
//                 player_ptr.action_points2 -= 1

//                 tile.occupied = true
//                 produce(tile, player_ptr)
//                 tile.harvested = true
//             }
//             else if player_ptr.action_points3 > 0 && !tile.harvested && !tile.invaded{
//                 player_ptr.action_points3 -= 1
//                 tile.occupied = true
//                 produce(tile, player_ptr)
//                 tile.harvested = true   

//             }

//         }
//     }

    
// }

// if rl.IsMouseButtonDown(.RIGHT) {
//     for tile in tiles {
//         if rl.CheckCollisionPointRec(point, tile. rect){
//             rl.draw_text(tile.kind, {f32(50), f32(300)}, 40, rl.BLACK)
//             rl.draw_text(fmt.tprintf("{}", tile.production_value), {f32(60), f32(350)}, 40, rl.BLACK)
            
//         }
        
//     }
// }

// }
// invasion_check :: proc()-> bool{
//     invasion: bool
//     switch rand.int32_range(0, 10){
//         case 0..=5:
//             invasion = true
//         case 6..=10:
//             invasion = false
//     }
//     return invasion
// }

// invade_tile :: proc(tiles: [dynamic]Tile){
//     invaded := rand.int_range(0, len(tiles) - 1)
//     tiles[invaded].invaded = true


// }