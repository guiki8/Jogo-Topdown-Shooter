/// Create Event — obj_Enemy

// Máquina de estados: patrol, attack, chase, flee, melee, return
state               = "patrol";

speed_walk          = 0.5;
speed_chase         = 1.0;
speed_flee          = 1.0;

patrol_point_a      = [ x, y ];
patrol_point_b      = [ x + 100, y ];
patrol_target       = patrol_point_b;

chase_radius        = 60;    // quando começa a perseguir na ausência de visão
lose_radius         = 80;    // quando desiste da perseguição
vision_radius       = 150;   // alcance de visão / ataque à distância
enemy_vision_radius = 150;   // alcance de visão / ataque à distância
min_attack_dist     = 50;    // distância mínima para kitear
ideal_attack_dist   = 100;   // distância ideal para atirar

player              = objPlayer;

// Movimento / flip
base_xscale         = 1;
hmove               = 0;
vmove               = 0;

// Arma do inimigo
gunNumber           = 2;
has_weapon          = true;
enemy_barrel_radius = 12;

// Munição
enemy_ammo          = 20;

// Instancia a arma
var g = instance_create_layer(x, y, "Instances", objEnemyGun_1);
g.owner     = id;
g.gunNumber = gunNumber;
