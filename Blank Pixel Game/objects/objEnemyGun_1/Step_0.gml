// ---------------------------------------------
// Arma solta quando sem munição
// ---------------------------------------------
if (owner.enemy_ammo <= 0) {
	
	owner.has_weapon = false

    // Se ainda não foi solta, inicializa
    if (!is_thrown) {
        is_thrown = true;
        sprite_index = sprEnemyGun_1;
        image_index = 0;

        // Salva a direção fixa para onde a arma será jogada
        throw_dir = point_direction(x, y, objPlayer.x, objPlayer.y);

        // Profundidade para ficar no chão
        depth = owner.depth + 1;
    }

    // Gira continuamente
    image_angle += 10;

    // Move na direção fixa salva
    var throw_speed = 1.5;
    hspeed = lengthdir_x(throw_speed, throw_dir);
    vspeed = lengthdir_y(throw_speed, throw_dir);

    // Sai da lógica normal
    exit;
}


// ——————————————
// Posição em órbita do owner
// ——————————————
var orbit_center_x = 0;
var orbit_center_y = owner.y - 3;

// --- Mira no player ou para frente ---
var angle = owner.image_angle;

if (point_distance(owner.x, owner.y, objPlayer.x, objPlayer.y) <= owner.enemy_vision_radius) {
    angle = point_direction(x, y, objPlayer.x, objPlayer.y);
    orbit_center_x = owner.x + (objPlayer.x < owner.x ? -8 : 8);
    image_xscale = 1;
} else {
    orbit_center_x = owner.x + (owner.image_xscale == 1 ? 6 : -46);
    image_xscale = owner.image_xscale;
}

// ——————————————
// Orbita o inimigo
// ——————————————
var wx = orbit_center_x + lengthdir_x(radius, angle) + lengthdir_x(offset_distance, angle);
var wy = orbit_center_y + lengthdir_y(radius, angle) + lengthdir_y(offset_distance, angle);
x = wx;
y = wy;
image_angle = angle;
image_yscale = (angle > 90 && angle < 270) ? -1 : 1;

// ——————————————
// Animação de tiro
// ——————————————
if (shooting_timer > 0) {
    shooting_timer += 1;
    if (shooting_timer >= 10) {
        image_index = 0;
        shooting_timer = 0;
    }
}

// ——————————————
// Cooldown
// ——————————————
if (cooldown_timer > 0) {
    cooldown_timer -= 1;
}

// ——————————————
// Disparo automático
// ——————————————
if (cooldown_timer <= 0
    && owner.enemy_ammo > 0
    && point_distance(owner.x, owner.y, objPlayer.x, objPlayer.y) <= owner.enemy_vision_radius) {
    
    // Cria projétil
    var b = instance_create_layer(x, y, "Instances", bullet_type);
    b.direction   = angle;
    b.image_angle = angle;
    b.x += lengthdir_x(12, angle);
    b.y += lengthdir_y(12, angle);

    // Efeito de tiro
    image_index     = 1;
    shooting_timer  = 1;
    cooldown_timer  = cooldown_max;
    owner.enemy_ammo -= 1;
}
