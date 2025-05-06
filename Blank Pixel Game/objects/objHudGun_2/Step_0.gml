// No Step ou onde você está checando o tiro:

if (image_index >= image_number - 1) {
    image_speed = 0;
    image_index = image_number - 1;
}

// Atualiza o sprite quando atira e ainda tem munição
if (objGun_1.is_collected && objPlayer.has_weapon == 1 && image_index >= image_number - 1) {
    if (objGun_1.shooting_timer > 0) {
        if (ammo < 6) {
			ammo += 1;
		} else {
			ammo = 6
		}

        // Altere o sprite com base no valor da munição
        var new_sprite = asset_get_index("sprGun_1_" + string(ammo));
        if (new_sprite != -1) {
            sprite_index = new_sprite;
            image_speed = 1;
            image_index = 0;
        }
    }
}
