// Máquina de estados: patrol, attack, chase, flee, melee, return
state               = "patrol";

speed_walk          = 0.5;
speed_chase         = 0.5;
speed_flee          = 0.5;

patrol_point_a      = [ x, y ];
patrol_point_b      = [ x + 100, y ];
patrol_target       = patrol_point_b;

chase_radius        = 60;
lose_radius         = 80;
vision_radius       = 150;
enemy_vision_radius = 150;
min_attack_dist     = 50;
ideal_attack_dist   = 100;

player              = objPlayer;

base_xscale         = 1;
hmove               = 0;
vmove               = 0;

gunNumber           = 2;
has_weapon          = true;
enemy_barrel_radius = 12;

enemy_ammo          = 20;

// Instancia a arma
var g = instance_create_layer(x, y, "Instances", objEnemyGun_1);
g.owner     = id;
g.gunNumber = gunNumber;

// Pathfinding
path_grid = mp_grid_create(0, 0, room_width div 32, room_height div 32, 32, 32);
mp_grid_add_instances(path_grid, objWall, false);
path = path_add();
path_timer = 0;

// Visão
vision_fov = 90;
last_seen_x = 0;
last_seen_y = 0;
saw_player = false;

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
