// —————————————————————————————————————————
// 1) Máquina de estados
// —————————————————————————————————————————
// Ataque
var look_dir = (image_xscale == 1) ? 0 : 180;
var dist_to_player = point_distance(x, y, objPlayer.x, objPlayer.y);
var dir_to_player = point_direction(x, y, objPlayer.x, objPlayer.y);
var angle_diff = angle_difference(look_dir, dir_to_player);
var can_see_player = false;

var wall_in_way = collision_line(x, y, objPlayer.x, objPlayer.y, objWall, false, true);

if (dist_to_player <= vision_range) {
    if (abs(angle_diff) <= vision_fov * 0.5) {
        if (wall_in_way == noone) {
            can_see_player = true;
		}
    }
}

if (can_see_player) {
    state = "shoot";
} else {
    state = "patrol"; // ou chase, patrol, etc
}

// Patrulha
if (state == "patrol") {
    // Ponto atual da patrulha
    var tx = patrol_points[patrol_index][0];
    var ty = patrol_points[patrol_index][1];

    // Direção até o ponto
    var dir = point_direction(x, y, tx, ty);

    // Movimento
    hmove = lengthdir_x(patrol_speed, dir);
    vmove = lengthdir_y(patrol_speed, dir);

    x += hmove;
    y += vmove;

    // Chegou no ponto?
    if (point_distance(x, y, tx, ty) < 2) {
        patrol_index = (patrol_index + 1) mod array_length(patrol_points);
    }
}

// —————————————————————————————————————————
// 2) Calcula movimento real para flip
// —————————————————————————————————————————
hmove = x - xprevious;
vmove = y - yprevious;

// —————————————————————————————————————————
// 3) Sprite e Animação
// —————————————————————————————————————————
if (hmove != 0) {
    image_xscale = base_xscale * sign(hmove);
}

if (hmove != 0 || vmove != 0) {
	if (has_weapon) {
		sprite_index = sprEnemyWalk_1;
    }else {
        sprite_index = sprEnemyWalk;
    }
} else {
    if (has_weapon) {
		sprite_index = sprEnemyIdle_2;
    }else {
        sprite_index = sprEnemyIdle;}
}

// Profundidade
if (objPlayer.y > y){
	depth = -9
}else{
	depth = -11}