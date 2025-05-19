player = objPlayer;

base_xscale = 1;
hmove = 0;
vmove = 0;
last_x = x;
last_y = y;

gunNumber = 2;
has_weapon = true;
ammo = 20;

// Instancia a arma
var g = instance_create_layer(x, y, "Instances", objEnemyGun_1);
g.owner = id;
g.gunNumber = gunNumber;

// Pathfinding
path_grid = mp_grid_create(0, 0, room_width div 32, room_height div 32, 32, 32);
mp_grid_add_instances(path_grid, objWall, false);
path = path_add();
path_timer = 0;

// Visão
vision_fov = 90;
vision_range = 160;
last_seen_x = 0;
last_seen_y = 0;
saw_player = false;

// Patrulha
patrol_points = [
    [x - 50, y],
	[x + 50, y]
];
patrol_index = 0;
patrol_speed = 0.5;
move_speed = 1;
state = "patrol";

// Função de linha de visão com ângulo
function has_line_of_sight(target) {
    if (!instance_exists(target)) return false;
    var angle_to_player = point_direction(x, y, target.x, target.y);
    var facing_angle = image_xscale >= 0 ? 0 : 180;
    var angle_diff = angle_difference(angle_to_player, facing_angle);
    if (abs(angle_diff) > vision_fov / 2) return false;
    if (collision_line(x, y, target.x, target.y, objWall, true, false)) return false;
    return true;
}
