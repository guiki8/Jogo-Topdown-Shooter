// Herda do pai
event_inherited();

// Só atira se equipada
if (!is_collected || objPlayer.has_weapon != idGun) exit;

// Se o botão foi clicado e cooldown já passou
if (mouse_check_button_pressed(mb_left) && cooldown_timer <= 0) {
    // Cria o projétil
    var base_dir = point_direction(x, y, mouse_x, mouse_y);
    var num_bullets = 5;         // Quantidade de projéteis
    var spread = 20;             // Ângulo total de espalhamento (graus)
    var offset_dist = 10;

    for (var i = 0; i < num_bullets; i++) {
        // Espalha os tiros igualmente ao redor do centro
        var angle_offset = lerp(-spread/2, spread/2, i / (num_bullets - 1));
        var shot_dir = base_dir + angle_offset;

        var bullet = instance_create_layer(x, y, "Instances", bullet_type);
        bullet.direction = shot_dir;
        bullet.image_angle = shot_dir;
        bullet.x += lengthdir_x(offset_dist, shot_dir);
        bullet.y += lengthdir_y(offset_dist, shot_dir);
    }

    // Disparo visual
    image_index    = 1;
    shooting_timer = 1;

    // Reinicia cooldown
    cooldown_timer = cooldown_max;
}