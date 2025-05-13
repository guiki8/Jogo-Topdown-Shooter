// Raio mínimo de distância
var raio_min = 50;

// Centro do círculo (ajustável)
var centro_x = objPlayer.x;
var centro_y = objPlayer.y;

// Cor e transparência
draw_set_color(c_white);
draw_set_alpha(1);

// Desenha apenas o contorno do círculo
draw_circle(centro_x, centro_y, raio_min, true);

// Restaura a opacidade para o restante dos desenhos
draw_set_alpha(1);

// Desenha a sprite normalmente
draw_self();
