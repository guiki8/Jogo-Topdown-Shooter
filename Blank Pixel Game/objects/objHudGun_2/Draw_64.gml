var cols = 7;
var rows = 3;
var spacing_x = 15;
var spacing_y = 25;
var start_x = 580;
var start_y = 125;

for (var i = 0; i < global.bullet_max; i++) {
    var col = i mod cols;
    var row = i div cols;

    var xx = start_x + col * spacing_x;
    var yy = start_y + row * spacing_y;

    // Inverter a ordem do índice
	var reversed_i = global.bullet_max - i;

	// Criar variável frame
	var frame = 0;

	if (reversed_i < ammo + 1) {
		// Ainda tem bala nessa posição, mostrar o último frame (bala cheia)
		frame = 1;
	} else {
		// Não tem bala, mostrar o primeiro frame (bala vazia)
		frame = 0;
	}

	if (objGun_2.shooting_timer > 0) {
		draw_sprite_ext(sprHudBullet_1, frame, xx, yy, 3, 3, 0, c_white, 1);
	} else {
		draw_sprite_ext(sprHudBullet, frame, xx, yy, 3, 3, 0, c_white, 1);
	}
}

draw_text(30, 30, "shooting_timer: " + string(objGun_2.shooting_timer));
draw_text(10, 120, "ammo: " + string(ammo));