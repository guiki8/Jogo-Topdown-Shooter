/// Create Event — obj_Enemy

/// Máquina de estados e patrulha
state            = "patrol";                  // "patrol", "chase", "return"
speed_walk       = 0.5;
speed_chase      = 1;
patrol_point_a   = [ x, y ];
patrol_point_b   = [ x + 100, y ];
patrol_target    = patrol_point_b;
chase_radius     = 60;
lose_radius      = 80;
player           = objPlayer;

/// Movimento / flip
move_speed       = 2.0;                       // usado pela IA
base_xscale      = 1;
hmove            = 0;
vmove            = 0;

/// Arma do inimigo
gunNumber        = 2;                         // ID desta arma
has_weapon       = gunNumber;                 
cooldown_timer   = 0;
cooldown_max     = 30;
enemy_barrel_radius = 12;
enemy_vision_radius = 150;

/// Munição do inimigo (global)
enemy_ammo   = 20;
global.enemy_has_ammo   = 20;
global.enemy_can_shoot  = false;

/// Cria e equipa o objeto arma
var g = instance_create_layer(x, y, "Instances", objEnemyGun_1);
g.owner     = id;
g.gunNumber = gunNumber;
