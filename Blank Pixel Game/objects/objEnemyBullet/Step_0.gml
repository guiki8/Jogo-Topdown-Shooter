// Colidiu com a parede?
if (!hit){
    if (place_meeting(x, y, objWall)) {
        hit = true;
        hit_timer = 10;          // quantos ticks a animação dura
        image_speed = 0.5;
        speed = 0;               // para a bala
	}
} else {
    hit_timer--;

    // Quando acabar o tempo, some
    if (hit_timer <= 0) {
        instance_destroy();
    }
}