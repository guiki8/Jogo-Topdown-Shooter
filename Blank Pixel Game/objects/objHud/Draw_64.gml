// Verifica se o jogador tem uma arma equipada
if (objPlayer.has_weapon != 0) {
    // Procura pela instância da arma equipada
    var gun = noone;
    with (objGunBase) {
        // Verifica se o gunNumber da instância é igual ao da arma equipada do jogador e se é a mesma instância
        if (gunNumber == objPlayer.has_weapon && id == objPlayer.equipped_weapon) {
            gun = id;
        }
    }

    if (gun != noone) {
        // Calcula a porcentagem de cooldown restante
        var percent = 1 - (gun.cooldown_timer / gun.cooldown_max);
        percent = clamp(percent, 0, 1);

        // Desenhar a barra de cooldown
        var bar_x = 50;
        var bar_y = 50;
        var bar_w = 100;
        var bar_h = 10;

        // Barra de fundo (para o cooldown)
        draw_set_color(c_black);
        draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);

        // Barra de cooldown (com base na porcentagem calculada)
        draw_set_color(c_lime);
        draw_rectangle(bar_x, bar_y, bar_x + (bar_w * percent), bar_y + bar_h, false);

        // Exibir o gunNumber acima da arma
        var text_x = bar_x + bar_w / 2;  // Centraliza o texto em relação à barra
        var text_y = bar_y - 15;         // Ajusta a posição vertical do texto acima da barra

        // Desenha o gunNumber
        draw_set_color(c_white);  // Cor do texto
        draw_text(text_x, text_y, "Gun #: " + string(gun.gunNumber));  // Exibe gunNumber
    }
}
