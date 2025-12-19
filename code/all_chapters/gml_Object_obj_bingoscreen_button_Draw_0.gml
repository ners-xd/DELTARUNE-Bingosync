/// IMPORT

scr_get_temp_draw();
draw_set_font(font);
draw_set_alpha(1);

if (outline_size > 0)
{
    draw_set_color(hovering ? hover_color : outline_color);
    ossafe_fill_rectangle(x - outline_size, y - outline_size, x2 + outline_size, y2 + outline_size, false);
}

draw_set_color(rectangle_color);
ossafe_fill_rectangle(x, y, x2, y2, false);
var text_x = (x + x2) / 2;
var text_y = (y + y2) / 2;

if (sprite != noone)
{
    text_x = (x + 3 + (2 * sprite_get_width(sprite)) + x2) / 2;
    draw_sprite_ext(sprite, sprite_frame, x + 3, y + 3, 2, 2, 0, hovering ? hover_color : c_white, 1);
}

draw_set_color(hovering ? hover_color : text_color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_ext(text_x, text_y, text, 15, x2);
draw_on_top();
scr_set_temp_draw();