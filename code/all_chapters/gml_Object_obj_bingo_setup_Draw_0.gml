/// IMPORT

scr_get_temp_draw();
draw_set_font(fnt_main);
draw_sprite(spr_bingosync_menu, 0, 0, 0);

if (obj_time.newest_mod_version != "")
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_red);
#if CHAPTER_1 || CHAPTER_2
    draw_text_outline(width / 2, 10, ">> Your mod is outdated. The latest release is " + obj_time.newest_mod_version + ". <<");
#else
    draw_text_outline(width / 2, 10, ">> Your mod is outdated. The latest release is v" + obj_time.newest_mod_version + ". <<");
#endif
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(status_color);
draw_text_outline_ext(width / 2, height - 60, status_text, 15, width);
bg_draw();

if (!obj_time.internet)
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_red);
    draw_text_outline(1, height - 17, "Internet connection not found!");
}

if (draw_close_x != -1 && draw_close_y != -1 && async_string == -1)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_ltgray);
    var gp_key = scr_input_name_gp(global.input_g[5]);

    if (is_string(gp_key))
    {
        draw_text_outline(draw_close_x, draw_close_y, "Press ESC or " + gp_key + " to go back.");
    }
    else
    {
        var before_text = "Press ESC or";
        var after_text = "to go back.";
        var total_w = string_width(before_text) + sprite_get_width(gp_key) + string_width(after_text);
        draw_text_outline(draw_close_x, draw_close_y, "Press ESC or      to go back.");
        draw_sprite_ext(gp_key, 0, round((draw_close_x - (total_w / 2)) + string_width(before_text)), draw_close_y - 7, 1, 1, 0, c_ltgray, 1);
    }

    if (assigning_keybind != "")
    {
        draw_set_color(c_yellow);
        draw_text_outline(draw_close_x, draw_close_y - 25, "Listening...");
    }
}

draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_yellow);
#if CHAPTER_1 || CHAPTER_2
draw_text_outline(width, height - 33, "Bingosync Mod (" + scr_get_mod_version() + ")\nDELTARUNE Chapter " + string(global.chapter) + " (" + global.version + ")");
#else
draw_text_outline(width, height - 33, "Bingosync Mod (v" + scr_get_mod_version() + ")\nDELTARUNE Chapter " + string(global.chapter) + " (" + global.versionno + ")");
#endif
scr_set_temp_draw();