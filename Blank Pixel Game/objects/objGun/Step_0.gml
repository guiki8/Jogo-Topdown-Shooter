/// Step Event

// 1) Se ainda não foi coletada, só faz o “highlight” e sai
if (!is_collected) {
    if (point_distance(x, y, objPlayer.x, objPlayer.y) <= pickup_radius) {
        image_index = 1;    // frame “pronta para pegar”
    } else {
        image_index = 0;    // frame “no chão”
    }
    exit; // não segue o player nem atira
}

// 2) Se coletada, permite largar com Q
if (keyboard_check_pressed(ord("Q"))) {
    // solta a arma
    is_collected        = false;
    objPlayer.has_weapon = false;
    sprite_index        = sprGun;
    image_index         = 0;
    x                   = objPlayer.x;
    y                   = objPlayer.y + 30;
    image_angle         = 0;
    image_yscale        = 3;
    if (instance_exists(objCrosshair)) instance_destroy(objCrosshair);
    exit; // volta a exibir no chão
}

// 3) Segue o player em órbita, posiciona e vira sprite
var angle = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var orbit_center_x = objPlayer.x + (mouse_x < objPlayer.x ? -25 : 25);
var orbit_center_y = objPlayer.y - 10;
var radius         = 10;
var offset_distance= 30;

// posição radial + offset
var wx = orbit_center_x + lengthdir_x(radius, angle);
var wy = orbit_center_y + lengthdir_y(radius, angle);
wx += lengthdir_x(offset_distance, angle);
wy += lengthdir_y(offset_distance, angle);

x = wx; 
y = wy;
image_angle = angle;
image_xscale = 3;
image_yscale = (angle > 90 && angle < 270) ? -3 : 3;

// garante sprite correto
if (sprite_index != sprGun_1) sprite_index = sprGun_1;

// 4) Cria a mira se ainda não existir
if (!instance_exists(objCrosshair)) {
    instance_create_layer(mouse_x, mouse_y, "Instances", objCrosshair);
}

// 5) Controla animação de tiro sem usar alarm
if (shooting_timer > 0) {
    shooting_timer += 1;
    if (shooting_timer >= 10) {
        image_index    = 0;  // volta ao idle da arma
        shooting_timer = 0;
    }
}
