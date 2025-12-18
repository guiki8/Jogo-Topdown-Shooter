// ---------------------------------------------
// obj_EnemyGun — Create Event
// ---------------------------------------------

gunNumber       = 1;
spriteBase      = sprEnemyGun_1;       // sprite base (caso precise)
spriteHand      = sprEnemyGun_1Hand;   // sprite usada quando equipada
owner           = noone;        // inimigo que possui esta arma
radius          = 16;
offset_distance = 4;
cooldown_timer  = 0;
cooldown_max    = 30;
shooting_timer  = 0;
bullet_type     = objEnemyBullet; // tipo de projétil inimigo
is_thrown = false;
throw_dir = 0;
image_index     = 0;
image_angle     = 0;
image_speed = 0;
depth           = -20;
hit = false; // foi arremessada
hit_timer = 0;