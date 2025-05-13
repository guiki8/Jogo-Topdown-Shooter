// ---------------------------------------------
// obj_EnemyGun — Step Event
// ---------------------------------------------

if (!instance_exists(owner)) {
    instance_destroy(); // destrói arma se o dono morreu
    exit;
}
var orbit_center_x = 0;
var orbit_center_y = owner.y - 3;

// --- Mira no player ou para frente ---
var angle = owner.image_angle;

// Se o player esta visivel
if (point_distance(owner.x, owner.y, objPlayer.x, objPlayer.y) <= owner.enemy_vision_radius) {
    angle = point_direction(x, y, objPlayer.x, objPlayer.y);
	orbit_center_x = owner.x + (objPlayer.x < owner.x ? -8 : 8);
	image_xscale = 1
	
// Se nao ve o player
} else {
	orbit_center_x = owner.x + (owner.image_xscale == 1 ? 6 : -46);
	image_xscale = owner.image_xscale
}

// --- Orbita o inimigo ---

var wx = orbit_center_x + lengthdir_x(radius, angle) + lengthdir_x(offset_distance, angle);
var wy = orbit_center_y + lengthdir_y(radius, angle) + lengthdir_y(offset_distance, angle);
x = wx;
y = wy;
image_angle = angle;
image_yscale = (angle > 90 && angle < 270) ? -1 : 1;

// --- Animação de tiro ---
if (shooting_timer > 0) {
    shooting_timer += 1;
    if (shooting_timer >= 10) {
        image_index = 0;
        shooting_timer = 0;
    }
}

// --- Cooldown ---
if (cooldown_timer > 0) {
    cooldown_timer -= 1;
}

// --- Disparo automático ---
if (cooldown_timer <= 0 && owner.enemy_ammo > 0 && (point_distance(owner.x, owner.y, objPlayer.x, objPlayer.y) <= owner.enemy_vision_radius)) {
    // Cria projétil
    var b = instance_create_layer(x, y, "Instances", bullet_type);
    b.direction   = angle;
    b.image_angle = angle;
    b.x += lengthdir_x(12, angle);
    b.y += lengthdir_y(12, angle);

    // Efeito de tiro
    image_index = 1;
    shooting_timer = 1;
    cooldown_timer = cooldown_max;
    owner.enemy_ammo -= 1;
}
