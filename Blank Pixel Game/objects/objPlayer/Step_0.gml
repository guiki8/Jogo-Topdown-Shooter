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
    image_xscale = base_xscale * sign(hmove);
}

// Aplicar movimento
x += hmove * move_speed;
y += vmove * move_speed;

// Considerar direção do flip
var is_facing_left = (image_xscale < 0);

// Trocar animação com base no movimento
if (hmove != 0 || vmove != 0) {
    if (is_facing_left) {
        if (mouse_x < x) {
            if (sprite_index != sprPlayerWalk) {
                sprite_index = sprPlayerWalk;
                image_speed = 1;
            }
        } else {
            if (sprite_index != sprPlayerWalk_2) {
                sprite_index = sprPlayerWalk_2;
                image_speed = 1;
            }
        }
    } else {
        if (mouse_x < x) {
            if (sprite_index != sprPlayerWalk_2) {
                sprite_index = sprPlayerWalk_2;
                image_speed = 1;
            }
        } else {
            if (sprite_index != sprPlayerWalk) {
                sprite_index = sprPlayerWalk;
                image_speed = 1;
            }
        }
    }
} else {
    if (is_facing_left) {
        if (mouse_x < x) {
            if (sprite_index != sprPlayerIdle) {
                sprite_index = sprPlayerIdle;
                image_speed = 0.2;
            }
        } else {
            if (sprite_index != sprPlayerIdle_2) {
                sprite_index = sprPlayerIdle_2;
                image_speed = 0.2;
            }
        }
    } else {
        if (mouse_x < x) {
            if (sprite_index != sprPlayerIdle_2) {
                sprite_index = sprPlayerIdle_2;
                image_speed = 0.2;
            }
        } else {
            if (sprite_index != sprPlayerIdle) {
                sprite_index = sprPlayerIdle;
                image_speed = 0.2;
            }
        }
    }
}
