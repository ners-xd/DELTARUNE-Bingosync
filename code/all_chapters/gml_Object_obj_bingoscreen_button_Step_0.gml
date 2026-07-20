/// IMPORT

if (!obj_time.mouse_visible)
    exit;

if (point_in_rectangle(obj_time.mousex, obj_time.mousey, x - outline_size, y - outline_size, x2 + outline_size, y2 + outline_size))
{
    if (!hovering)
    {
        hovering = true;
        snd_play(snd_menumove);

        with (obj_bingo_setup)
        {
            status_color = other.hover_text_color;
            status_text = other.hover_text;
        }

        with (obj_bingo_settings_screen)
            error_text = "";
    }

    if (scr_check_mouse_pressed(mb_left, global.input_g[4]))
    {
        snd_play(snd_select);
        on_click();
    }
}
else if (hovering)
{
    hovering = false;

    with (obj_bingo_setup)
    {
        if (status_text == other.hover_text)
            status_text = "";
    }

    with (obj_bingo_settings_screen)
        error_text = "";
}