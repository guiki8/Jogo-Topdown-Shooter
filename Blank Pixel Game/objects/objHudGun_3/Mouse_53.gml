if (global.can_shoot) {
    if (ammo == 1) global.has_ammo = false;
	
    // Altere o sprite com base no valor da munição
    var new_sprite = asset_get_index("sprGun_3_" + string(ammo + 1));
    if (new_sprite != -1) {
		sprite_index = new_sprite;
		image_speed = 1;
		image_index = 0;
		// Cria a cap da bala
		instance_create_layer(global.hud_position[0] + 155, global.hud_position[1] + 43, "Hud", objHudBulletCap_1)
    }
}