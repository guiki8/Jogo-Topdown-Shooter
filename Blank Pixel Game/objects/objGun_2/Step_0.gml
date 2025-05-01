// Herda do pai
event_inherited();

// Só atira se equipada
if (!is_collected || objPlayer.has_weapon != idGun) exit;

// Se o botão foi clicado e cooldown já passou
if (mouse_check_button_pressed(mb_left) && cooldown_timer <= 0) {
    // Cria o projétil
    var bullet = instance_create_layer(x, y, "Instances", bullet_type);

    var dir = point_direction(x, y, mouse_x, mouse_y);
    bullet.direction    = dir;
    bullet.image_angle  = dir;

    var offset_dist = 10;
    bullet.x += lengthdir_x(offset_dist, dir);
    bullet.y += lengthdir_y(offset_dist, dir);

    // Disparo visual
    image_index    = 1;
    shooting_timer = 1;

    // Reinicia cooldown
    cooldown_timer = cooldown_max;
}
