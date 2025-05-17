draw_self();

// ---------------------------------------------
// Campo de visão em forma de cone
// ---------------------------------------------
var fov_angle = 60; // deve ser o mesmo usado no step
var ray_count = 16;
var angle_start = image_angle - fov_angle / 2;
var angle_end   = image_angle + fov_angle / 2;

draw_set_color(c_red);
draw_primitive_begin(pr_trianglestrip);
draw_vertex(x, y);

for (var i = 0; i <= ray_count; i++) {
    var a = angle_start + (i / ray_count) * fov_angle;
    var px = x + lengthdir_x(vision_radius, a);
    var py = y + lengthdir_y(vision_radius, a);
    draw_vertex(px, py);
}
draw_primitive_end();

// ---------------------------------------------
// Raios de comportamento
// ---------------------------------------------
draw_set_color(c_white);
draw_circle(x, y, min_attack_dist, true);

draw_set_color(c_yellow);
draw_circle(x, y, ideal_attack_dist, true);

// ---------------------------------------------
// Texto de debug
// ---------------------------------------------
draw_set_color(c_white);
draw_set_font(Pixel);
draw_text(x - 10, y - 30, "State: " + state);
draw_text(x - 10, y - 20, "Ammo: " + string(enemy_ammo));

// ---------------------------------------------
// Caminho de patrulha
// ---------------------------------------------
draw_set_color(c_blue);
draw_line(patrol_point_a[0], patrol_point_a[1], patrol_point_b[0], patrol_point_b[1]);
draw_circle(patrol_point_a[0], patrol_point_a[1], 4, true);
draw_circle(patrol_point_b[0], patrol_point_b[1], 4, true);

// ---------------------------------------------
// Linha de visão até o player
// ---------------------------------------------
draw_set_color(has_line_of_sight(player) ? c_lime : c_gray);
draw_line(x, y, player.x, player.y);

if (saw_player) {
    draw_set_color(c_lime);
    draw_circle(last_seen_x, last_seen_y, 4, false);
    draw_line(x, y, last_seen_x, last_seen_y);
}
