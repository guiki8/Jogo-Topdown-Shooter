draw_self();

// -------------------------------------------------
// Campo de visão (cone)
// -------------------------------------------------
var range = vision_range;
var fov   = vision_fov;
var dir   = image_xscale >= 0 ? 0 : 180;

draw_set_color(c_yellow);
draw_set_alpha(0.3);

var steps = 24;
for (var i = -fov / 2; i <= fov / 2; i += fov / steps) {
    var a  = dir + i;
    var x2 = x + lengthdir_x(range, a);
    var y2 = y + lengthdir_y(range, a);
    draw_line(x, y, x2, y2);
}

draw_set_alpha(1);

// -------------------------------------------------
// Linha de visão até o player
// -------------------------------------------------
// Origem da visão
var ox = x;
var oy = y - 4;

// Linha até o player
if (point_distance(x, y, objPlayer.x, objPlayer.y) <= range) {

    if (can_see_player) { // << Ve o player
        draw_set_color(c_lime);  // Player no alcance mas fora do campo de visao vv
    } else if ((dist_to_player <= vision_range) and (abs(angle_diff) <= vision_fov * 0.5) ){
        draw_set_color(c_red);
    } else { // Player fora do alcance e campo de visao
		draw_set_color(c_gray);
	}

    draw_line(ox, oy, objPlayer.x, objPlayer.y);
}

// ------------------------------------
// Área da última posição vista
// ------------------------------------
if (player_last_pos[0] != 0 || player_last_pos[1] != 0) {

    if (can_see_player) {
        draw_set_color(c_lime);   // vendo agora
    } else {
        draw_set_color(c_red);    // perdeu o player
    }

    draw_set_alpha(0.35);
    draw_circle(
        player_last_pos[0],
        player_last_pos[1],
        20,
        false
    );
    draw_set_alpha(1);
}

draw_set_color(c_white);


// -------------------------------------------------
// Rota de patrulha
// -------------------------------------------------
draw_set_color(c_red);

for (var i = 0; i < array_length(patrol_points); i++) {
    var px = patrol_points[i][0];
    var py = patrol_points[i][1];
    draw_circle(px, py, 4, false);

    if (i < array_length(patrol_points) - 1) {
        var nx = patrol_points[i + 1][0];
        var ny = patrol_points[i + 1][1];
        draw_line(px, py, nx, ny);
    }
}

if (array_length(patrol_points) > 1) {
    draw_line(
        patrol_points[array_length(patrol_points) - 1][0],
        patrol_points[array_length(patrol_points) - 1][1],
        patrol_points[0][0],
        patrol_points[0][1]
    );
}

// -------------------------------------------------
// Estado atual (debug)
// -------------------------------------------------
draw_set_color(c_white);
draw_text(x - 20, y - 40, string(state));
draw_text(x - 40, y - 40, string(chase_timer));
draw_text(x - 20, y - 28, string(ammo));
draw_text(x - 20, y - 16, string(image_xscale));
