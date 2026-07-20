/// PATCH

/// APPEND
if (mouse_visible)
    draw_sprite_ext(spr_maus_cursor, 0, mousex, mousey, 0.5, 0.5, 0, c_white, 1);

if (!instance_exists(obj_bingo_settings_screen))
{
    scr_get_temp_draw();
    draw_set_alpha(1);

    if (global.show_chat)
    {
        var ypos = 0;
        var message_height = 0;
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

    if (room != ROOM_INITIALIZE && !instance_exists(obj_screen_loading) && global.hit_counter)
    {
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_font(fnt_mainbig);
        draw_set_color(c_yellow);
        draw_text_outline(2, global.chat_typing ? (surface_get_height(application_surface) - 90) : (surface_get_height(application_surface) - 30), "Hits: " + string(global.hits));
    }

    scr_set_temp_draw();
}
/// END