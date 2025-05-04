// Herda o evento do pai
event_inherited();

// Só atira se a arma estiver equipada
if (!is_collected || objPlayer.has_weapon != gunNumber) exit;

// Verifica se o botão foi pressionado e o cooldown já passou
if (mouse_check_button_pressed(mb_left) && cooldown_timer <= 0 && objHudGun_1.ammo != 6) {
    // Cria o projétil
    var bullet = instance_create_layer(x, y, "Instances", bullet_type);

    // Calcula a direção do mouse
    var dir = point_direction(x, y, mouse_x, mouse_y);
    bullet.direction    = dir;
    bullet.image_angle  = dir;

    // Offset para a posição de disparo
    var offset_dist = 10;
    bullet.x += lengthdir_x(offset_dist, dir);
    bullet.y += lengthdir_y(offset_dist, dir);

    // Animação do disparo
    image_index    = 1;
    shooting_timer = 1;

    // Reinicia o cooldown
    cooldown_timer = cooldown_max;
}

// Controla o cooldown de disparo
if (cooldown_timer > 0) {
    cooldown_timer -= 1;
}
