// Movimento em arco
x += hsp;
y += vsp;
vsp += gravity; // gravidade atua para baixo

// Rotação
image_angle += rot_speed;

// Destruir quando sair da tela ou cair
if (y > 80) {
    instance_destroy();
}