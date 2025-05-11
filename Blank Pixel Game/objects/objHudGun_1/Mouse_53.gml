if (global.can_shoot) {
    if (ammo == 5) global.has_ammo = false;
	
    // Altere o sprite com base no valor da munição
    var new_sprite = asset_get_index("sprGun_1_" + string(ammo + 1));
    if (new_sprite != -1) {
    sprite_index = new_sprite;
    image_speed = 1;
    image_index = 0;
    }
}