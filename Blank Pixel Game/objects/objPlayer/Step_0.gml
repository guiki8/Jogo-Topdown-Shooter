// Resetar movimento
var hmove = 0;
var vmove = 0;

// Verificar teclas pressionadas
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    hmove = 1;
}
if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    hmove = -1;
}
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
    vmove = 1;
}
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
    vmove = -1;
}

// Normalizar movimento diagonal
var move_length = point_distance(0, 0, hmove, vmove);
if (move_length > 0) {
    hmove /= move_length;
    vmove /= move_length;
}

// Sprite inverte para esquerda/direita
if (hmove != 0) {
    image_xscale = base_xscale * hmove;
}

// Aplicar movimento
x += hmove * move_speed;
y += vmove * move_speed;

// Trocar animação com base no movimento
if (hmove != 0 || vmove != 0) {
    if (sprite_index != sprPlayerWalk) {
        sprite_index = sprPlayerWalk;
        image_speed = 1; // velocidade normal da animação
    }
} else {
    if (sprite_index != sprPlayerIdle) {
        sprite_index = sprPlayerIdle;
        image_speed = 0.2; // mais lento se quiser
    }
}
