/// Global Mouse Left Pressed

// 1) Se ainda não foi coletada e estiver no raio, coleta a arma
if (!is_collected) {
    if (point_distance(x, y, objPlayer.x, objPlayer.y) <= pickup_radius) {
        is_collected         = true;
        objPlayer.has_weapon = true;
		image_index = 0
        // garante que a mira e o cursor sejam configurados no Step
        exit;  // sai aqui para não executar o disparo no mesmo clique
    }
}

// 2) Se já foi coletada, faz o disparo
if (is_collected) {
    var bullet = instance_create_layer(x, y, "Instances", objBullet);
    var dir    = point_direction(x, y, mouse_x, mouse_y);
    bullet.direction   = dir;
    bullet.image_angle = dir;
    // offset para sair da ponta da arma
    var od = 10;
    bullet.x += lengthdir_x(od, dir);
    bullet.y += lengthdir_y(od, dir);

    // animação de tiro
    image_index    = 1;   // frame de disparo
    shooting_timer = 1;   // inicia contagem para voltar ao idle
}
