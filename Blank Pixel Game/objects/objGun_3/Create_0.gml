// Herda o evento do pai
event_inherited();

// Define o sprite específico e a bala usada
sprite_idle   = sprGun_3Hand;
sprite_ground = sprGun_3;
cooldown_max  = 100;          // Tempo de recarga em frames (1/60s por frame)
cooldown_timer = 0;
bullet_type   = objBullet;    // Projétil usado por essa arma

spriteBase    = sprGun_3;
spriteHand    = sprGun_3Hand;

// ID da arma (para referência)
gunNumber = 3;  // Representa o tipo da arma