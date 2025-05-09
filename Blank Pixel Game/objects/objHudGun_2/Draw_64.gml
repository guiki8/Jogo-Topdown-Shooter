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

    // A ordem de gasto invertida
    var reversed_i = global.bullet_max - 1 - i;

    var frame = (reversed_i < global.bullet_count) ? sprite_get_number(sprHudBullet) - 1 : 0;

    draw_sprite_ext(sprHudBullet, frame, xx, yy, 3, 3, 0, c_white, 1);
}
