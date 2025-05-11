// Herda do pai
event_inherited();

// Só atira se a arma estiver equipada
if (!is_collected || objPlayer.has_weapon != gunNumber) exit;

if (cooldown_timer <= 0 && global.has_ammo = true) {
	global.can_shoot = true
}

// Se o botão está pressionado e o cooldown já passou
if (mouse_check_button(mb_left) && global.can_shoot = true) {
    // Cria o projétil
    var bullet = instance_create_layer(x, y, "Instances", bullet_type);
	
	global.can_shoot = false
	
	if (objHudGun_2.ammo < 20) objHudGun_2.ammo += 1;
	
	gastar_bala();

    // Calcula a direção do disparo
    var dir = point_direction(x, y, mouse_x, mouse_y);
    bullet.direction   = dir;
    bullet.image_angle = dir;

    // Adiciona o offset para o projétil (desloca um pouco do ponto de origem)
    var offset_dist = 10;
    bullet.x += lengthdir_x(offset_dist, dir);
    bullet.y += lengthdir_y(offset_dist, dir);

    // Animação do disparo (para a arma)
    image_index    = 1;
    shooting_timer = 1;

    // Reinicia o cooldown
    cooldown_timer = cooldown_max;
	
	// Cria a cap na Hud
	instance_create_layer(objHudGun_2.x + 155, objHudGun_2.y + 43, "Hud", objHudBulletCap)
}

// Controla o cooldown de disparo
if (cooldown_timer > 0) {
    cooldown_timer -= 1;
}