if !is_collected {
	// Deixa a sombra mais transparente
	draw_set_alpha(0.5);

	// Desenha uma elipse achatada como sombra
	draw_ellipse_color(x - 6, yoriginal + 8, x + 6, yoriginal + 12, c_black, c_black, false);

	// Restaura a opacidade normal
	draw_set_alpha(1);
}

// Desenha o sprite do item
draw_self();