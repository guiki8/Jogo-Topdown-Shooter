// Primeiro desenha o sprite normalmente
draw_self();

// Ativa modo de debug visual
var col_patrol = c_lime;
var col_chase = c_red;
var col_return = c_yellow;
var col_text = c_white;

// Círculo do raio de perseguição
draw_set_color(c_red);
draw_circle(x, y, chase_radius, true);

// Círculo do raio de desistência da perseguição
draw_set_color(c_orange);
draw_circle(x, y, lose_radius, true);

// Círculo do raio de visao do inimigo
draw_set_color(c_blue);
draw_circle(x, y, enemy_vision_radius, true);

// Pontos de patrulha
draw_set_color(c_lime);
draw_circle(patrol_point_a[0], patrol_point_a[1], 3, true);
draw_circle(patrol_point_b[0], patrol_point_b[1], 3, true);

// Linha entre os pontos de patrulha
draw_line(patrol_point_a[0], patrol_point_a[1], patrol_point_b[0], patrol_point_b[1]);

// Linha até o jogador se estiver perseguindo
if (state == "chase") {
    draw_set_color(c_red);
    draw_line(x, y, player.x, player.y);
}

// Texto com o estado atual
draw_set_color(col_text);
draw_set_font(Pixel)
draw_text(x - 10, y - 30, "State: " + state);
draw_text(x - 10, y - 20, "Ammo: " + string(enemy_ammo));