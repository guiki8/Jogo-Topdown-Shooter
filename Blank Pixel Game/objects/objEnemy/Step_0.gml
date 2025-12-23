// Atirar
if (state == "shoot"){
	vision_fov = 360;
	vision_range = 300;
	player_last_pos[0] = objPlayer.x
	player_last_pos[1] = objPlayer.y
	
// Patrulha
} else if (state == "patrol") {
	vision_fov = 160;
	vision_range = 200;
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

// Perseguir
} else if (state == "chase"){
	chase_timer --
	if (chase_timer <= 0) {
		saw_player = false
	}
	// Ponto atual do movimento
    var tx = player_last_pos[0];
    var ty = player_last_pos[1];

    // Direção até o ponto
    var dir = point_direction(x, y, tx, ty);

    // Movimento
    hmove = lengthdir_x(move_speed, dir);
    vmove = lengthdir_y(move_speed, dir);

    x += hmove;
    y += vmove;

    // Chegou no ponto?
    if (point_distance(x, y, tx, ty) < 2) {
        chase_timer = 0;
		player_last_pos[0] = 0
		player_last_pos[1] = 0
    }
}

// Calcula movimento real para flip
hmove = x - xprevious;
vmove = y - yprevious;