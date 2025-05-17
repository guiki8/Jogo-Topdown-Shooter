/// Step Event — obj_Enemy

var dx = player.x - x;
var dy = player.y - y;
var dist = point_distance(x, y, player.x, player.y);

/// —————————————————————————————————————————
///  1) Transições de Estado
/// —————————————————————————————————————————

switch (state) {

    case "patrol":
        // Se vir o player
        if (dist <= vision_radius) {
            state = enemy_ammo > 0 ? "attack" : "melee";
            break;
        }
        // Patrulha normal
        move_towards_point(patrol_target[0], patrol_target[1], speed_walk);
        if (point_distance(x, y, patrol_target[0], patrol_target[1]) < 4) {
            patrol_target = (patrol_target == patrol_point_a) ? patrol_point_b : patrol_point_a;
        }
        break;


    case "attack":
        // Sem munição vira corpo a corpo
        if (enemy_ammo <= 0) {
            state = "melee";
            break;
        }
        // Se perder visão, partir pra perseguição de longo alcance
        if (dist > vision_radius) {
            state = "chase";
            break;
        }
        // Se muito perto, fugir para manter distância mínima
        if (dist < min_attack_dist) {
            state = "flee";
            break;
        }
        // Caso esteja longe demais, avançar para ficar em distância ideal
        if (dist > ideal_attack_dist) {
            state = "chase";
            break;
        }
        // Continua em attack enquanto estiver na faixa de [min_attack_dist, vision_radius]
        break;


    case "chase":
        // Se perder completamente o jogador, volta patrulhar
        if (dist > lose_radius && dist > vision_radius) {
            state = "return";
            // escolhe ponto de patrulha mais próximo
            patrol_target =
                point_distance(x, y, patrol_point_a[0], patrol_point_a[1]) <
                point_distance(x, y, patrol_point_b[0], patrol_point_b[1])
                ? patrol_point_a : patrol_point_b;
            break;
        }
        // Se voltar à distância de ataque
        if (dist <= ideal_attack_dist && dist <= vision_radius && enemy_ammo > 0) {
            state = "attack";
            break;
        }
        // Se chegar perto demais, troca pra flee
        if (dist < min_attack_dist) {
            state = "flee";
            break;
        }
        break;


    case "flee":
		if (enemy_ammo <= 0) {
			state = "melee";
			break;
		}

		// Calcula um ponto longe do player (espelhado) para onde fugir
		var away_x = x + (x - player.x);
		var away_y = y + (y - player.y);
		move_towards_point(away_x, away_y, speed_flee);

		// Transições de volta
		if (dist >= min_attack_dist && dist <= ideal_attack_dist) {
			state = "attack";
		} else if (dist > vision_radius) {
			state = "chase";
		}
		break;


    case "melee":
        // Corpo a corpo: persegue sempre até colidir
        if (dist > 4) {
            // continua melee
        } else {
            // aqui você pode disparar animação de ataque corpo a corpo
        }
        break;


    case "return":
        // Volta ao ponto de patrulha definido
        move_towards_point(patrol_target[0], patrol_target[1], speed_walk);
        if (point_distance(x, y, patrol_target[0], patrol_target[1]) < 4) {
            state = "patrol";
        }
        // Se avistar o player no retorno
        if (dist <= vision_radius) {
            state = enemy_ammo > 0 ? "attack" : "melee";
        }
        break;
}


/// —————————————————————————————————————————
///  2) Movimento real (hmove/vmove e flip)
/// —————————————————————————————————————————

var speed_current = point_distance(0, 0, hspeed, vspeed);
if (speed_current > 0) {
    hmove = hspeed / speed_current;
    vmove = vspeed / speed_current;
} else {
    hmove = 0; vmove = 0;
}

if (hmove != 0) {
    image_xscale = base_xscale * sign(hmove);
}


/// —————————————————————————————————————————
///  3) Ação de movimento por estado
/// —————————————————————————————————————————

switch (state) {
    case "attack":
        // Fica parado atirando (objEnemyGun_1 cuida do disparo)
        hspeed = 0; vspeed = 0;
        break;
    case "chase":
        move_towards_point(player.x, player.y, speed_chase);
        break;
    case "flee":
		// Calcula ponto espelhado para se afastar usando move_towards_point
		var away_x = x + (x - player.x);
		var away_y = y + (y - player.y);
		move_towards_point(away_x, away_y, speed_flee);
		break;
    case "melee":
        move_towards_point(player.x, player.y, speed_chase);
        break;
    // patrol e return já movem no bloco de transição
}

/// ---------------------------------------------
/// SPRITE e ANIMAÇÃO
/// ---------------------------------------------

// Flip horizontal com base no movimento
if (hmove != 0) {
    image_xscale = base_xscale * sign(hmove);
}

// Está se movendo?
if (hmove != 0 || vmove != 0) {
    // Walk (movimento)
    if (has_weapon) {
        if (image_xscale < 0) {
            sprite_index = (player.x < x) ? sprEnemyWalk_1 : sprEnemyWalk_2;
        } else {
            sprite_index = (player.x < x) ? sprEnemyWalk_2 : sprEnemyWalk_1;
        }
		if !(point_distance(x, y, objPlayer.x, objPlayer.y) <= enemy_vision_radius) {
				sprite_index = sprEnemyWalk_1;
		}
    } else {
        sprite_index = sprEnemyWalk;
    }

    image_speed = 1;
} else {
    // Idle (parado)
    if (has_weapon) {
        if (image_xscale > 0) {
            sprite_index = (player.x < x) ? sprEnemyIdle_1 : sprEnemyIdle_2;
        } else {
            sprite_index = (player.x < x) ? sprEnemyIdle_2 : sprEnemyIdle_1;
        }
    } else {
        sprite_index = sprEnemyIdle;
    }

    image_speed = 1;
}



/// —————————————————————————————————————————
///  4) Debug drawing
/// —————————————————————————————————————————

draw_self();
// raios
draw_set_color(c_red);    draw_circle(x, y, vision_radius, true);
draw_set_color(c_orange); draw_circle(x, y, min_attack_dist, true);
draw_set_color(c_yellow); draw_circle(x, y, ideal_attack_dist, true);
draw_set_color(c_white);  draw_text(x-10, y-30, "State: " + state);
draw_set_color(c_white);  draw_text(x-10, y-20, "Ammo: " + string(enemy_ammo));