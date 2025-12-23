// —————————————————————————————————————————
// Sprite e Animação
// —————————————————————————————————————————
if (hmove != 0) {
    image_xscale = base_xscale * sign(hmove);
} else if (can_see_player) {
	if (x > objPlayer.x){
		image_xscale = -base_xscale
	} else {
		image_xscale = base_xscale
	}
}

if (hmove != 0 || vmove != 0) {
	if (has_weapon) {
		sprite_index = sprEnemyWalk_1;
    }else {
        sprite_index = sprEnemyWalk;
    }
} else {
    if (has_weapon) {
		sprite_index = sprEnemyIdle_2;
    }else {
        sprite_index = sprEnemyIdle;}
}

// Profundidade
if (objPlayer.y > y){
	depth = -9
}else{
	depth = -11}