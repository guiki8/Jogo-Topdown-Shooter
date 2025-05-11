// 1) Destaque ao se aproximar
if (!is_collected) {
    if (point_distance(x, y, objPlayer.x, objPlayer.y) <= pickup_radius) {
        image_index = 1;
        if (!instance_exists(key_e)) {
            key_e = instance_create_layer(x + (2 * gunNumber), y - 13, "Instances", objKeyE);
        }
    } else {
        image_index = 0;
        if (instance_exists(key_e)) instance_destroy(key_e);
    }
    exit;
}

// 2) Soltar arma com Q
if (keyboard_check_pressed(ord("Q"))) {
    is_collected             = false;
    objPlayer.has_weapon     = 0;
    objPlayer.equipped_weapon = noone; // limpa referência à arma
    sprite_index             = spriteBase;
    image_index              = 0;
    x                        = objPlayer.x;
    y                        = objPlayer.y + 10;
    image_angle              = 0;
    image_yscale             = 1;
    if (instance_exists(objCrosshair)) instance_destroy(objCrosshair);
    exit;
}

// 3) Segue o player e ajusta sprite
var angle           = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var orbit_center_x  = objPlayer.x + (mouse_x < objPlayer.x ? -8 : 8);
var orbit_center_y  = objPlayer.y - 3;
var radius          = 7;
var offset_distance = 10;
var wx              = orbit_center_x + lengthdir_x(radius, angle) + lengthdir_x(offset_distance, angle);
var wy              = orbit_center_y + lengthdir_y(radius, angle) + lengthdir_y(offset_distance, angle);

x = wx;
y = wy;
image_angle   = angle;
image_xscale  = 1;
image_yscale  = (angle > 90 && angle < 270) ? -1 : 1;
if (sprite_index != spriteHand) sprite_index = spriteHand;

// 4) Cria mira
if (!instance_exists(objCrosshair)) {
    instance_create_layer(mouse_x, mouse_y, "Instances", objCrosshair);
    objCrosshair.image_index = gunNumber - 1;
}

// 5) Controla animação de tiro
if (shooting_timer > 0) {
    shooting_timer += 1;
    if (shooting_timer >= 10) {
        image_index    = 0;
        shooting_timer = 0;
    }
}

// 6) Controla cooldown de disparo
if (cooldown_timer > 0) {
    cooldown_timer -= 1;
}
