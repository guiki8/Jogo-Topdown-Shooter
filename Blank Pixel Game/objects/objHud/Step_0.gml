if (objPlayer.has_weapon == 1) {
    if (!instance_exists(objHudGun_1)) instance_create_layer(10, 10, "Hud", objHudGun_1);
    instance_destroy(objHudGun_2);
    instance_destroy(objHudGun_3);
}
else if (objPlayer.has_weapon == 2) {
    if (!instance_exists(objHudGun_2)) instance_create_layer(10, 10, "Hud", objHudGun_2);
    instance_destroy(objHudGun_1);
    instance_destroy(objHudGun_3);
}
else if (objPlayer.has_weapon == 3) {
    if (!instance_exists(objHudGun_3)) instance_create_layer(10, 10, "Hud", objHudGun_3);
    instance_destroy(objHudGun_1);
    instance_destroy(objHudGun_2);
} 
else {
	instance_destroy(objHudGun_1);
	instance_destroy(objHudGun_2);
    instance_destroy(objHudGun_3);
}