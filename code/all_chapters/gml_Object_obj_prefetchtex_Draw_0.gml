/// PATCH .ignore if CHAPTER_1

/// AFTER
if (draw)
{
/// CODE
    scr_get_temp_draw();
/// END

/// BEFORE
}
/// CODE
    draw_set_font(fnt_main);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (variable_global_exists("num_goals") && variable_global_exists("tier1_goals"))
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
/// END