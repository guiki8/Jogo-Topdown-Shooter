// No Step ou onde você está checando o tiro:

if (image_index >= image_number - 1) {
    image_speed = 0;
    image_index = image_number - 1;
}

// Atualiza o sprite quando atira e ainda tem munição
if (objGun_3.is_collected && objPlayer.has_weapon == 3 && image_index >= image_number - 1) {
    if (objGun_3.shooting_timer > 0) {
        if (ammo < 2) {
			ammo += 1;
		} else {
			ammo = 2
		}

        // Altere o sprite com base no valor da munição
        var new_sprite = asset_get_index("sprGun_3_" + string(ammo));
        if (new_sprite != -1) {
            sprite_index = new_sprite;
            image_speed = 1;
            image_index = 0;
        }
    }
}
