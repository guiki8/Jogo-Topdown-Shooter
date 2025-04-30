// Ângulo entre o player e o mouse
var angle = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

// Centro da órbita varia conforme o lado do mouse
var orbit_center_x = objPlayer.x;
var orbit_center_y = objPlayer.y -10;

var center_offset = 25; // quanto deslocar o centro para os lados
if (mouse_x < objPlayer.x) {
    orbit_center_x -= center_offset;
} else {
    orbit_center_x += center_offset;
}

// Distância da arma ao redor do novo centro
var radius = 10;

// Offset radial da arma (ex: para alinhar com a mão)
var offset_angle = 0;
var offset_distance = 30;

// Posição da arma com órbita + offset
var weapon_x = orbit_center_x + lengthdir_x(radius, angle);
var weapon_y = orbit_center_y + lengthdir_y(radius, angle);

weapon_x += lengthdir_x(offset_distance, angle + offset_angle);
weapon_y += lengthdir_y(offset_distance, angle + offset_angle);

// Aplicar posição
x = weapon_x;
y = weapon_y;

// Arma aponta para o mouse
image_angle = angle;

// Inverter sprite da arma se estiver na esquerda
if (angle > 90 && angle < 270) {
    image_yscale = -4;
} else {
    image_yscale = 4;
}
