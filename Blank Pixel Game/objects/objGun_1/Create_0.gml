// Inherit the parent event
event_inherited();

// Apenas define o sprite específico e a bala usada
sprite_idle   = sprGun_1Hand;
sprite_ground = sprGun_1;
cooldown_max = 50;          // tempo de recarga em frames (1/60s por frame)
cooldown_timer = 0;
bullet_type = objBullet;  // projétil usado por essa arma

spriteBase = sprGun_1
spriteHand = sprGun_1Hand

idGun = 1