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

// Patrulha
patrol_points = [
    [x - 50, y],
	[x + 50, y]
];
patrol_index = 0;
patrol_speed = 0.5;
move_speed = 1;
state = "patrol";
