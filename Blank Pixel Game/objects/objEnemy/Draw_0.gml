/// Draw Event — obj_Enemy

draw_self();

// Raios de debug de comportamento
// Alcance de visão (atacar à distância)
draw_set_color(c_red);
draw_circle(x, y, vision_radius, true);

// Distância mínima de ataque (flee se menor)
draw_set_color(c_green);
draw_circle(x, y, min_attack_dist, true);

// Distância ideal de ataque (kite)
draw_set_color(c_yellow);
draw_circle(x, y, ideal_attack_dist, true);

// Informações de estado
draw_set_color(c_white);
draw_set_font(Pixel);
draw_text(x - 10, y - 30, "State: " + state);
draw_text(x - 10, y - 20, "Ammo: " + string(enemy_ammo));
