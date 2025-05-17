var dx = player.x - x;
var dy = player.y - y;
var dist = point_distance(x, y, player.x, player.y);

// Atualiza se viu o jogador
if (point_distance(x, y, player.x, player.y) <= vision_radius && has_line_of_sight(player)) {
    saw_player = true;
    last_seen_x = player.x;
    last_seen_y = player.y;
} else if (point_distance(x, y, last_seen_x, last_seen_y) > lose_radius) {
    saw_player = false;
}

// —————————————————————————————————————————
// 1) Transições de Estado
// —————————————————————————————————————————
switch (state) {

    case "patrol":
        if (saw_player) {
            state = enemy_ammo > 0 ? "attack" : "melee";
            break;
        }
        if (point_distance(x, y, patrol_target[0], patrol_target[1]) < 4) {
            patrol_target = (patrol_target == patrol_point_a) ? patrol_point_b : patrol_point_a;
        }
        break;

    case "attack":
        if (enemy_ammo <= 0) {
            state = "melee";
            break;
        }
        if (!saw_player) {
            state = "chase";
            break;
        }
        if (dist < min_attack_dist) {
            state = "flee";
            break;
        }
        if (dist > ideal_attack_dist) {
            state = "chase";
            break;
        }
        break;

    case "chase":
        if (!saw_player && point_distance(x, y, last_seen_x, last_seen_y) < 4) {
            state = "return";
            patrol_target = 
                point_distance(x, y, patrol_point_a[0], patrol_point_a[1]) <
                point_distance(x, y, patrol_point_b[0], patrol_point_b[1])
                ? patrol_point_a : patrol_point_b;
            break;
        }

        if (saw_player && dist <= ideal_attack_dist && enemy_ammo > 0) {
            state = "attack";
            break;
        }

        if (saw_player && dist < min_attack_dist) {
            state = "flee";
            break;
        }

        if (saw_player && point_distance(x, y, last_seen_x, last_seen_y) > 4) {
            move_towards_point(last_seen_x, last_seen_y, speed_chase);
        }
        break;

    case "flee":
        if (enemy_ammo <= 0) {
            state = "melee";
            break;
        }

        if (dist >= min_attack_dist && dist <= ideal_attack_dist) {
            state = "attack";
        } else if (!saw_player) {
            state = "chase";
        }
        break;

    case "melee":
        if (dist > 4) {
            // continua perseguindo
        } else {
            // ataque corpo a corpo pode ser acionado aqui
        }
        break;

    case "return":
        if (point_distance(x, y, patrol_target[0], patrol_target[1]) < 4) {
            state = "patrol";
        }

        if (saw_player) {
            state = enemy_ammo > 0 ? "attack" : "melee";
        }
        break;
}

// —————————————————————————————————————————
// 2) Movimento com colisão por estado
// —————————————————————————————————————————
hmove = 0;
vmove = 0;

switch (state) {

    case "attack":
        break;

    case "chase":
    case "melee":
        if (dist > 0) {
            hmove = dx / dist * speed_chase;
            vmove = dy / dist * speed_chase;
        }
        break;

    case "flee":
        if (dist > 0) {
            hmove = -dx / dist * speed_flee;
            vmove = -dy / dist * speed_flee;
        }
        break;

    case "patrol":
    case "return":
        var tx = patrol_target[0] - x;
        var ty = patrol_target[1] - y;
        var len = point_distance(0, 0, tx, ty);
        if (len > 0) {
            hmove = tx / len * speed_walk;
            vmove = ty / len * speed_walk;
        }
        break;
}

// Movimento com colisão
if (!place_meeting(x + hmove, y, objWall)) x += hmove;
if (!place_meeting(x, y + vmove, objWall)) y += vmove;

// —————————————————————————————————————————
// 3) Sprite e Animação
// —————————————————————————————————————————
if (hmove != 0) image_xscale = base_xscale * sign(hmove);

if (hmove != 0 || vmove != 0) {
    if (has_weapon) {
        sprite_index = (image_xscale < 0) 
            ? (player.x < x ? sprEnemyWalk_1 : sprEnemyWalk_2)
            : (player.x < x ? sprEnemyWalk_2 : sprEnemyWalk_1);

        if (!(point_distance(x, y, objPlayer.x, objPlayer.y) <= saw_player)) {
            sprite_index = sprEnemyWalk_1;
        }
    } else {
        sprite_index = sprEnemyWalk;
    }
    image_speed = 1;
} else {
    if (has_weapon) {
        sprite_index = (image_xscale > 0) 
            ? (player.x < x ? sprEnemyIdle_1 : sprEnemyIdle_2)
            : (player.x < x ? sprEnemyIdle_2 : sprEnemyIdle_1);
    } else {
        sprite_index = sprEnemyIdle;
    }
    image_speed = 1;
}

if (saw_player) {
    draw_set_color(c_lime);
    draw_circle(last_seen_x, last_seen_y, 4, false);
    draw_line(x, y, last_seen_x, last_seen_y);
}
