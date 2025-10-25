/// PATCH

/// APPEND
var temp_halign = draw_get_halign();
var temp_valign = draw_get_valign();
var temp_alpha = draw_get_alpha();

if (global.show_chat)
{
    var ypos = 0;
    var message_height = 0;

    if (global.returning_to_title && instance_exists(obj_fadeout))
        draw_set_alpha(1 - obj_fadeout.image_alpha);
    else
        draw_set_alpha(1);

    draw_set_font(fnt_main);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    for (var i = 0; i < array_length(global.chat_line); i++)
    {
        message_height = string_height_ext(global.chat_line[i], 15, 330);
        draw_set_color(global.chat_color[i]);
        draw_text_outline_ext(2, ypos, global.chat_line[i], 15, 330);
        ypos += message_height;
    }
}

if (global.hit_counter)
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(fnt_mainbig);
    draw_set_color(c_yellow);
    draw_text_outline(5, global.chat_typing ? (surface_get_height(application_surface) - 80) : (surface_get_height(application_surface) - 30), "Hits: " + string(global.hits), c_black);
}

draw_set_halign(temp_halign);
draw_set_valign(temp_valign);
draw_set_alpha(temp_alpha);
/// END