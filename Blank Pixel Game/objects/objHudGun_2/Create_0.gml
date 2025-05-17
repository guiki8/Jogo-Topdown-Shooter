depth = -100
image_speed = 1
x = global.hud_position[0]
y = global.hud_position[1]
ammo = 0

global.bullet_max = 20;
global.bullet_count = 0;
global.bullet_anim_frame = array_create(global.bullet_max, 0); // Cada bala começa no frame 0

global.bullet_frames = array_create(global.bullet_max, 1); // Começam cheias
global.bullet_flash_timer = array_create(global.bullet_max, 0); // Temporizadores

cols = 7;
rows = 3;
spacing_x = 15;
spacing_y = 25;
start_x = global.hud_position[0] + 370;
start_y = global.hud_position[1] * 3.47;