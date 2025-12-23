//----------------------------------------
// Máquina de estado
//----------------------------------------

var wall_in_way = collision_line(x, y, objPlayer.x, objPlayer.y, objWall, false, true);

look_dir = (image_xscale == 1) ? 0 : 180;
dir_to_player = point_direction(x, y, objPlayer.x, objPlayer.y);
angle_diff = angle_difference(look_dir, dir_to_player);
dist_to_player = point_distance(x, y, objPlayer.x, objPlayer.y);
can_see_player = false;
 
if (dist_to_player <= vision_range) {
    if (abs(angle_diff) <= vision_fov * 0.5) {
        if (wall_in_way == noone) {
            can_see_player = true;
			chase_timer = 300;
			saw_player = true;
		}
    }
}

if (can_see_player) {
    state = "shoot";
} else if (saw_player) {
    state = "chase";
} else {
	state = "patrol";
}