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

    var reversed_i = global.bullet_max - i;
    var frame = (reversed_i < ammo + 1) ? 1 : 0;

    // Desenhar a bala normalmente
    if (objGun_2.shooting_timer > 0) {
        draw_sprite_ext(sprHudBullet_1, frame, xx, yy, 3, 3, 0, c_white, 1);
    } else {
        draw_sprite_ext(sprHudBullet, frame, xx, yy, 3, 3, 0, c_white, 1);
    }

    // Se a bala acabou de ficar vazia, inicia o timer do efeito
    if (global.bullet_frames[i] == 0 && frame == 1) {
        global.bullet_flash_timer[i] = 10; // Mostrar por 10 frames
    }

    // Se o timer ainda está rodando, desenhar o efeito extra
    if (global.bullet_flash_timer[i] > 0) {
        draw_sprite_ext(sprHudBullet, 2, xx, yy, 3, 3, 0, c_white, 1);
        global.bullet_flash_timer[i] -= 1;
    }

    // Atualizar o frame atual
    global.bullet_frames[i] = frame;
}
