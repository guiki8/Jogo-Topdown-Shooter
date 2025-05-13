/// ---------------------------------------------
/// VARIÁVEIS ÚTEIS
/// ---------------------------------------------
var dist_to_player = point_distance(x, y, player.x, player.y);

/// ---------------------------------------------
/// IA – Controle de Estados: Patrol, Chase, Return
/// ---------------------------------------------
switch (state) {
    case "patrol":
        // Caminha entre ponto A e B lentamente
        move_towards_point(patrol_target[0], patrol_target[1], speed_walk);

        // Alterna entre os pontos de patrulha ao chegar perto
        if (point_distance(x, y, patrol_target[0], patrol_target[1]) < 4) {
            patrol_target = (patrol_target == patrol_point_a) ? patrol_point_b : patrol_point_a;
        }

        // Se o jogador entrar no raio de perseguição, muda para "chase"
        if (dist_to_player < chase_radius) {
            state = "chase";
        }
        break;

    case "chase":
        // Persegue o jogador mais rapidamente
        move_towards_point(player.x, player.y, speed_chase);

        // Se o jogador escapar para longe, volta a patrulhar
        if (dist_to_player > lose_radius) {
            state = "return";

            // Decide o ponto de patrulha mais próximo para retornar
            patrol_target =
                point_distance(x, y, patrol_point_a[0], patrol_point_a[1]) <
                point_distance(x, y, patrol_point_b[0], patrol_point_b[1])
                ? patrol_point_a : patrol_point_b;
        }
        break;

    case "return":
        // Caminha de volta ao ponto mais próximo da patrulha
        move_towards_point(patrol_target[0], patrol_target[1], speed_walk);

        // Retorna ao estado de patrulha ao chegar
        if (point_distance(x, y, patrol_target[0], patrol_target[1]) < 4) {
            state = "patrol";
        }

        // Se o jogador reaparecer por perto, volta a perseguir
        if (dist_to_player < chase_radius) {
            state = "chase";
        }
        break;
}

/// ---------------------------------------------
/// MOVIMENTO: hmove e vmove normalizados
/// ---------------------------------------------
var speed_current = point_distance(0, 0, hspeed, vspeed);

if (speed_current > 0) {
    hmove = hspeed / speed_current;
    vmove = vspeed / speed_current;
} else {
    hmove = 0;
    vmove = 0;
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
        if (image_xscale < 0) {
            sprite_index = (player.x < x) ? sprEnemyIdle_1 : sprEnemyIdle_2;
        } else {
            sprite_index = (player.x < x) ? sprEnemyIdle_2 : sprEnemyIdle_1;
        }
    } else {
        sprite_index = sprEnemyIdle;
    }

    image_speed = 1;
}