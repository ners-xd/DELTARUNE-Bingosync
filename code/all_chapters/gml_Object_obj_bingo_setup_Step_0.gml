/// IMPORT

if ((instance_exists(obj_bingo_settings_screen) || (draw_close_x != -1 && draw_close_y != -1 && async_string == -1)) && scr_check_pressed(vk_escape, global.input_g[5]))
{
    var can_close = true;

    with (obj_bingo_settings_screen)
    {
        if (assigning_keybind != "")
            can_close = false;
    }

    if (can_close)
    {
        with (obj_bingo_settings_screen)
            instance_destroy();

        with (obj_bingoscreen_button)
            instance_destroy();

        bg_draw = function()
        {
            exit;
        };

        draw_close_x = -1;
        draw_close_y = -1;
        draw_main_buttons();
        keyboard_clear(vk_escape);
        snd_play(snd_swing);
    }
}

if (httppost != -1 && !obj_time.internet)
{
    httppost = -1;
    error_show("Can't connect without internet!");

    if (instance_exists(obj_bingo_controller))
        instance_destroy(obj_bingo_controller);

    if (global.ws_client != -1)
    {
        network_destroy(global.ws_client);
        global.ws_client = -1;
    }

    if (instance_exists(obj_fullscreen_fadeout))
    {
        mus_volume(global.currentsong[1], 0.7, 8);
        instance_destroy(obj_fullscreen_fadeout);

        with (instance_create(0, 0, obj_fadein))
            fadespeed = -0.16;
    }
}