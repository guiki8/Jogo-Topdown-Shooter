// Atualiza o sprite quando atira e ainda tem munição
if (image_index >= image_number - 1 && objGun_2.shooting_timer > 0) {
    if (ammo >= 20) {
		global.has_ammo = false
	}
	global.bullet_count = ammo
    // Altere o sprite com base no valor da munição
    sprite_index = sprGun_2_1;
    image_speed = 1;
    image_index = 0;
}