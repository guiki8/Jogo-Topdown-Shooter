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
// Linha de visão até o player (LOS)
// -------------------------------------------------
var dist_to_player = point_distance(x, y, objPlayer.x, objPlayer.y);
var dir_to_player  = point_direction(x, y, objPlayer.x, objPlayer.y);
var angle_diff     = angle_difference(dir, dir_to_player);

// Origem da visão (olhos)
var ox = x;
var oy = y - 4;

// Checa parede no caminho
var wall = collision_line(
    ox, oy,
    objPlayer.x, objPlayer.y,
    objWall,
    false,
    true
);

// Só desenha a linha se estiver dentro do alcance
if (dist_to_player <= range) {

    // Dentro do cone?
    if (abs(angle_diff) <= fov * 0.5) {
        draw_set_color(wall == noone ? c_lime : c_red);
    } else {
        draw_set_color(c_gray);
    }

    draw_line(ox, oy, objPlayer.x, objPlayer.y);
}

draw_set_color(c_white);

// -------------------------------------------------
// Rota de patrulha (debug)
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
draw_text(x - 20, y - 28, string(ammo));
draw_text(x - 20, y - 16, string(image_xscale));
