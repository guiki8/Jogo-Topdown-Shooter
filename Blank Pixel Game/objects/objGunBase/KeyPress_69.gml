// Coletar arma
if (!is_collected && point_distance(x, y, objPlayer.x, objPlayer.y) <= pickup_radius && objPlayer.has_weapon == 0) {
    is_collected               = true;
    objPlayer.has_weapon       = gunNumber;
    objPlayer.equipped_weapon  = id; // salva a instância real da arma
    image_index                = 0;
    if (instance_exists(key_e)) instance_destroy(key_e);
}
