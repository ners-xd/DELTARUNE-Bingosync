/// IMPORT

scr_get_temp_draw();
var progress = prog / array_length(pages);
yloc = -280 + (progress * 240);
var animindex = sprite_get_number(spr_dog_turn_full) * progress;
draw_sprite_ext(spr_dog_turn_full, animindex, 280, yloc - 28, 4, 4, 0, c_white, 1);
var border = 60;
var left = border;
var right = 640 - (border * 2);
var vloc = 460 - border;
draw_sprite_ext(spr_pxwhite, 0, left, vloc - 20, right, 20, 0, c_white, 1);
draw_sprite_ext(spr_pxwhite, 0, left + 2, (vloc - 20) + 2, right - 4, 16, 0, c_black, 1);
draw_sprite_ext(spr_pxwhite, 0, left + 4, (vloc - 20) + 4, (right - 8) * progress, 12, 0, c_white, 1);
draw_set_font(fnt_main);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (variable_global_exists("num_goals"))
{
    draw_set_color(c_lime);
    draw_text(320, vloc + 15, "Goal list retrieved!");
}
else if (obj_time.internet)
{
    draw_set_color(c_yellow);
    draw_text(320, vloc + 15, "Retrieving goal list...");
}
else if (!obj_time.internet)
{
    draw_set_color(c_red);
    draw_text_ext(320, vloc + 20, "Can't retrieve the goal list without internet!\nWaiting for a connection...", 15, right);
}
scr_set_temp_draw();