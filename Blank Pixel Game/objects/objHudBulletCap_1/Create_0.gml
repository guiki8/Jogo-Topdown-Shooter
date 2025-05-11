depth = -150
timer = 40

// Velocidade inicial da cápsula
hsp = random_range(-2, -1);           // velocidade horizontal
vsp = random_range(-2, -3);         // impulso vertical (pra cima)
gravity = 0.1;                      // gravidade para cair depois

// Rotação aleatória
image_angle = irandom(360);
rot_speed = random_range(-10, 10);  // velocidade de rotação

image_yscale = 1.3
image_xscale = 1.3