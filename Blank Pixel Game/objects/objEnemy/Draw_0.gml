draw_self()

// Campo de visão
var range = vision_range;
var fov = vision_fov;
var dir = image_xscale >= 0 ? 0 : 180;

draw_set_color(c_yellow);
draw_set_alpha(0.3);
var steps = 24;
for (var i = -fov / 2; i <= fov / 2; i += fov / steps) {
    var a = dir + i;
    var x2 = x + lengthdir_x(range, a);
    var y2 = y + lengthdir_y(range, a);
    draw_line(x, y, x2, y2);
}
draw_set_alpha(1);

// Linha até o último local onde o player foi visto
if (saw_player) {
    draw_set_color(c_lime);
    draw_circle(last_seen_x, last_seen_y, 4, false);
    draw_line(x, y, last_seen_x, last_seen_y);
}

// Rota de patrulha (debug)
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
    draw_line(patrol_points[array_length(patrol_points) - 1][0], patrol_points[array_length(patrol_points) - 1][1], patrol_points[0][0], patrol_points[0][1]);
}

// Estado atual
draw_set_color(c_white);
draw_text(x - 20, y - 40, string(state));
draw_text(x - 20, y - 28, string(hspeed));
draw_text(x - 20, y - 16, string(image_xscale));