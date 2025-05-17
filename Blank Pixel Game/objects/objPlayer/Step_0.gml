// Resetar movimento
var hmove = 0;
var vmove = 0;

// Verificar teclas pressionadas
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) hmove = 1;
if (keyboard_check(vk_left)  || keyboard_check(ord("A"))) hmove = -1;
if (keyboard_check(vk_down)  || keyboard_check(ord("S"))) vmove = 1;
if (keyboard_check(vk_up)    || keyboard_check(ord("W"))) vmove = -1;

// Normalizar movimento diagonal
var move_length = point_distance(0, 0, hmove, vmove);
if (move_length > 0) {
    hmove /= move_length;
    vmove /= move_length;
}

// Sprite inverte para esquerda/direita
if (hmove != 0) {
    image_xscale = base_xscale * sign(hmove);
}

// Aplicar movimento com colisão em X
var new_x = x + hmove * move_speed;
if (!place_meeting(new_x, y, objWall)) {
    x = new_x;
}

// Aplicar movimento com colisão em Y
var new_y = y + vmove * move_speed;
if (!place_meeting(x, new_y, objWall)) {
    y = new_y;
}

// Considerar direção do flip
var is_facing_left = (image_xscale < 0);

// --- ANIMAÇÃO ---
if (hmove != 0 || vmove != 0) {
    if (has_weapon != 0) {
        // Com arma
        if (is_facing_left) {
            sprite_index = (mouse_x < x) ? sprPlayerWalk_1 : sprPlayerWalk_2;
        } else {
            sprite_index = (mouse_x < x) ? sprPlayerWalk_2 : sprPlayerWalk_1;
        }
    } else {
        // Sem arma
        sprite_index = sprPlayerWalk;
    }
    image_speed = 1;
} else {
    if (has_weapon != 0) {
        if (is_facing_left) {
            sprite_index = (mouse_x < x) ? sprPlayerIdle_1 : sprPlayerIdle_2;
        } else {
            sprite_index = (mouse_x < x) ? sprPlayerIdle_2 : sprPlayerIdle_1;
        }
    } else {
        sprite_index = sprPlayerIdle;
    }
    image_speed = 1;
}
