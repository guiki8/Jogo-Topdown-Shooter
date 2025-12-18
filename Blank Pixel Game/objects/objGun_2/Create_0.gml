// Herda o evento do pai
event_inherited();

// Define o sprite específico e a bala usada
sprite_idle   = sprGun_2Hand;
sprite_ground = sprGun_2;
cooldown_max  = 30;          // Tempo de recarga em frames (1/60s por frame)
cooldown_timer = 0;
bullet_type   = objBullet;   // Projétil usado por essa arma

spriteBase    = sprGun_2;
spriteHand    = sprGun_2Hand;

// ID da arma (para referência)
gunNumber = 2;  // Representa o tipo da arma

shadow_type = 8;

function gastar_bala() {
    if (global.bullet_count < global.bullet_max) {
        global.bullet_count += 1;
    }
}