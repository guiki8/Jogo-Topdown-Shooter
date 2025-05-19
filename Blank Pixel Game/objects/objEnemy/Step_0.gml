// —————————————————————————————————————————
// 1) Máquina de estados
// —————————————————————————————————————————
switch (state) {
    case "patrol":
        var target_point = patrol_points[patrol_index];
        var tx = target_point[0];
        var ty = target_point[1];

        if (path_timer <= 0) {
            mp_grid_path(path_grid, path, x, y, tx, ty, true);
            path_start(path, patrol_speed, path_action_stop, false);
            path_timer = 30;
        } else {
            path_timer -= 1;
        }

        if (point_distance(x, y, tx, ty) < 8) {
            patrol_index = (patrol_index + 1) mod array_length(patrol_points);
            path_timer = 0;
        }

        if (has_line_of_sight(player)) {
            last_seen_x = player.x;
            last_seen_y = player.y;
            saw_player = true;
            path_end();
            state = "attack";
        }
        break;

    case "attack":
        hmove = 0;
        vmove = 0;

        if (!has_line_of_sight(player)) {
            state = "return";
        } else {
            last_seen_x = player.x;
            last_seen_y = player.y;
            saw_player = true;

            if (ammo <= 0) {
                state = "melee";
            } else {
                if (point_distance(x, y, player.x, player.y) < 60) {
                    state = "flee";
                }
            }
            // Continua atacando, arma cuida disso
        }
        break;

    case "chase":
        mp_grid_path(path_grid, path, x, y, player.x, player.y, true);
        path_start(path, move_speed, path_action_stop, false);
        break;

    case "flee":
        var angle_away = point_direction(player.x, player.y, x, y);
        var fx = x + lengthdir_x(40, angle_away);
        var fy = y + lengthdir_y(40, angle_away);
        mp_grid_path(path_grid, path, x, y, fx, fy, true);
        path_start(path, move_speed, path_action_stop, false);
        break;

    case "melee":
        mp_grid_path(path_grid, path, x, y, player.x, player.y, true);
        path_start(path, move_speed, path_action_stop, false);
        break;

    case "return":
        mp_grid_path(path_grid, path, x, y, last_seen_x, last_seen_y, true);
        path_start(path, move_speed, path_action_stop, false);

        if (point_distance(x, y, last_seen_x, last_seen_y) < 8) {
            state = "patrol";
            saw_player = false;
        }
        break;
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
        if (image_xscale < 0) {
            if (player.x < x) {
                sprite_index = sprEnemyWalk_1;
            } else {
                sprite_index = sprEnemyWalk_2;
            }
        } else {
            if (player.x < x) {
                sprite_index = sprEnemyWalk_2;
            } else {
                sprite_index = sprEnemyWalk_1;
            }
        }

        if (!(point_distance(x, y, objPlayer.x, objPlayer.y) <= saw_player)) {
            sprite_index = sprEnemyWalk_1;
        }
    } else {
        sprite_index = sprEnemyWalk;
    }
    image_speed = 1;
} else {
    if (has_weapon) {
        if (image_xscale > 0) {
            if (player.x < x) {
                sprite_index = sprEnemyIdle_1;
            } else {
                sprite_index = sprEnemyIdle_2;
            }
        } else {
            if (player.x < x) {
                sprite_index = sprEnemyIdle_2;
            } else {
                sprite_index = sprEnemyIdle_1;
            }
        }
    } else {
        sprite_index = sprEnemyIdle;
    }
    image_speed = 1;
}
