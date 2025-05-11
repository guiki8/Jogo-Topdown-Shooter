// Define os HUDs em um array
var gun_huds = [objHudGun_1, objHudGun_2, objHudGun_3];

// Checa se o jogador tem uma arma válida
var gun_index = objPlayer.has_weapon;
var current_hud = noone;

if (gun_index >= 1 && gun_index <= 3) {
    current_hud = gun_huds[gun_index - 1];

    if (!instance_exists(current_hud)) {
        instance_create_layer(10, 10, "Hud", current_hud);
    }
}

// Destroi os outros HUDs
if (current_hud != objHudGun_1) instance_destroy(objHudGun_1);
if (current_hud != objHudGun_2) instance_destroy(objHudGun_2);
if (current_hud != objHudGun_3) instance_destroy(objHudGun_3);