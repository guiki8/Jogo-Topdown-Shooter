// Herda o evento do pai
event_inherited();

// Apenas define o sprite específico e a bala usada
sprite_idle   = sprGun_1Hand;
sprite_ground = sprGun_1;
cooldown_max  = 50;          // Tempo de recarga em frames (1/60s por frame)
cooldown_timer = 0;
bullet_type   = objBullet;   // Projétil usado por essa arma

spriteBase    = sprGun_1;
spriteHand    = sprGun_1Hand;

// ID da arma (para referência)
gunNumber = 1;  // Representa o tipo da arma