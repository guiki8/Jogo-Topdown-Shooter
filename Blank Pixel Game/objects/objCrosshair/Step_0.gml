// Raio mínimo
var raio_min = 50;

// Centro customizado (ex: 50px acima do jogador)
var centro_x = objPlayer.x - 5;
var centro_y = objPlayer.y - 5;

// Cálculo da distância e direção
var dx = mouse_x - centro_x;
var dy = mouse_y - centro_y;
var dist = point_distance(mouse_x, mouse_y, centro_x, centro_y);
var dir = point_direction(centro_x, centro_y, mouse_x, mouse_y);

// Aplica a lógica
if (dist >= raio_min) {
    x = mouse_x;
    y = mouse_y;
} else {
    x = centro_x + lengthdir_x(raio_min, dir);
    y = centro_y + lengthdir_y(raio_min, dir);
}
