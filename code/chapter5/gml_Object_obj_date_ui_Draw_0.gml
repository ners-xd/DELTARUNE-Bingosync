/// PATCH

/// REPLACE
draw_set_halign(fa_center);
draw_text_color(608 + doki_x + _shakex, 30, stringsetloc("DOKI", "obj_date_ui_slash_Draw_0_gml_195_0"), c_white, c_white, c_white, c_white, 1);

if (i_ex(obj_pink_enemy))
    draw_text_color(608 + doki_x + _shakex, 47, string(obj_pink_enemy.doki) + "/" + string(dokimax), c_white, c_white, c_white, c_white, 1);
/// CODE
// Move the doki text because it's normally blocked by the room information
/// END

/// AFTER
gpu_set_blendmode(bm_normal);
/// CODE
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_font(fnt_main);

if (instance_exists(obj_pink_enemy))
    draw_text_outline_ext(sprite_width / 2, sprite_height / 2, "D\nO\nK\nI\n\n" + string(obj_pink_enemy.doki) + "\n/\n" + string(dokimax), 12, 300);

scr_84_set_draw_font("main");
/// END

/// APPEND
draw_set_valign(fa_top);
/// END