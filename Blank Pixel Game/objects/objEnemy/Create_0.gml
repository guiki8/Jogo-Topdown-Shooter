player = objPlayer;

base_xscale = 1;
hmove = 0;
vmove = 0;
last_x = x;
last_y = y;

gunNumber = 2;
has_weapon = true;
ammo = 10;

// Instancia a arma
var g = instance_create_layer(x, y, "Instances", objEnemyGun_1);
g.owner = id;
g.gunNumber = gunNumber;

// Visão
vision_fov = 160;
vision_range = 200;
dist_to_player = 0;
look_dir = 0;
angle_diff = 0;
dir_to_player = 0;
can_see_player = false;

// Ataque
saw_player = false;
chase_timer = 100;
player_last_pos = array_create(2, 0);

// Patrulha
patrol_points = [
    [x - 50, y + 50],
	[x + 50, y + 50],
	[x - 50, y - 50],
	[x + 50, y - 50]
];
patrol_index = 0;
patrol_speed = 0.5;
move_speed = 1;
state = "patrol";