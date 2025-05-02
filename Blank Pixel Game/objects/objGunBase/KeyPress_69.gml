// Coletar arma
if (!is_collected && point_distance(x, y, objPlayer.x, objPlayer.y) <= pickup_radius && objPlayer.has_weapon = 0) {
    is_collected         = true;
    objPlayer.has_weapon = idGun;
	image_index = 0
}