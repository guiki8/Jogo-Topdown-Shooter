if (point_distance(x, y, objPlayer.x, objPlayer.y) <= pickup_radius) {
    objPlayer.ammo += 3
	collected = true
	image_index = 1
}

if (collected = true){
	timer -= 1
	y -= 1
	image_alpha -= 0.02
}
if (timer = 0)
	instance_destroy(self)