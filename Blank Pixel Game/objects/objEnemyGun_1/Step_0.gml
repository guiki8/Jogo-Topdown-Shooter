// Verifica se pode atirar (estados "attack" ou "chase")
var can_shoot = owner.state == "shoot";

// ---------------------------------------------
// Arma é solta quando sem munição
// ---------------------------------------------
if (owner.ammo <= 0) {
    owner.has_weapon = false;

    if (!is_thrown) {
        is_thrown = true;
        sprite_index = sprEnemyGun_1;
        image_index = 0;

        // Salva direção para onde será lançada
        throw_dir = point_direction(x, y, objPlayer.x, objPlayer.y);
        depth = owner.depth + 1;
    }

	if (!hit){
		// Animação de rotação
		image_angle += 10;

		// Movimento da arma jogada
		var throw_speed = 1.5;
		hspeed = lengthdir_x(throw_speed, throw_dir);
		vspeed = lengthdir_y(throw_speed, throw_dir);

		// Colidiu com a parede?
		if (place_meeting(x, y, objWall)) {
			hit = true;
			hit_timer = 15;          // quantos ticks a animação dura
			image_speed = 0.5;
			speed = 0;               // para a bala
		}
	} else {
		hit_timer--;
		if (hit_timer <= 0) {
			instance_destroy();
		}
	}
    exit;
}

// ——————————————
// Posição em órbita do dono (owner)
// ——————————————
var orbit_center_x = 0;
var orbit_center_y = owner.y - 3;

var angle = owner.image_angle;

// Mira se inimigo vê o jogador e pode atirar
if (point_distance(owner.x, owner.y, objPlayer.x, objPlayer.y) <= owner.vision_range && can_shoot) {
    angle = point_direction(x, y, objPlayer.x, objPlayer.y);
    orbit_center_x = owner.x + (objPlayer.x < owner.x ? -8 : 8);
    image_xscale = 1;
} else {
    orbit_center_x = owner.x + (owner.image_xscale == 1 ? 6 : -46);
    image_xscale = owner.image_xscale;
}

// ——————————————
// Movimento orbital da arma
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
// Cooldown de disparo
// ——————————————
if (cooldown_timer > 0) {
    cooldown_timer -= 1;
}

// —————————————————————————————————————————————
// Disparo automático
// —————————————————————————————————————————————
if (
    cooldown_timer <= 0 &&
    owner.ammo > 0 &&
    can_shoot &&
    point_distance(owner.x, owner.y, objPlayer.x, objPlayer.y) <= owner.vision_range
) {
    var b = instance_create_layer(x, y, "Instances", bullet_type);
    b.direction   = angle;
    b.image_angle = angle;
    b.x += lengthdir_x(12, angle);
    b.y += lengthdir_y(12, angle);

    image_index     = 1;
    shooting_timer  = 1;
    cooldown_timer  = cooldown_max;
    owner.ammo -= 1;
}
