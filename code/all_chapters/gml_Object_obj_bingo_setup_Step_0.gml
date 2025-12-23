/// IMPORT

if (assigning_keybind != "")
{
    if (!clicked_button.first_frame_done)
    {
        clicked_button.first_frame_done = true;
        exit;
    }

    if (scr_check_pressed(vk_escape, global.input_g[5]))
    {
        assigning_keybind = "";
        clicked_button = noone;
        obj_time.mouse_visible = true;
        keyboard_clear(vk_escape);
        snd_play(snd_swing);
        exit;
    }

    var save = false;
    var _kb_key = ossafe_keyboard_lastkey();
    var _gp_key = scr_gamepad_lastkey();

    if (_kb_key > 1 && _kb_key < 256)
    {
        variable_global_set(assigning_keybind, _kb_key);
        save = true;
    }
    else if (_gp_key != 0)
    {
        variable_global_set(assigning_keybind + "_gp", _gp_key);
        save = true;
    }

    if (save)
    {
        scr_save_bingo_data();

        with (clicked_button)
        {
            text = string_copy(text, 1, string_pos(":\n", text)) + "\n" + scr_input_name(variable_global_get(other.assigning_keybind)) + "\n ";
            gp_key = scr_input_name_gp(variable_global_get(other.assigning_keybind + "_gp"));

            if (is_string(gp_key))
            {
                text = string_replace(text, "\n ", "\n" + gp_key);
            }
            else
            {
                draw_on_top = function()
                {
                    draw_sprite_ext(gp_key, 0, ((x + x2) / 2) - 6, y2 - sprite_get_height(gp_key) - 2, 1, 1, 0, hovering ? hover_color : c_white, 1);
                };
            }
        }

        snd_play(snd_select);
        assigning_keybind = "";
        clicked_button = noone;
        obj_time.mouse_visible = true;
    }
}
else if (draw_close_x != -1 && draw_close_y != -1 && async_string == -1 && scr_check_pressed(vk_escape, global.input_g[5]))
{
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

    if (instance_exists(obj_fadeout))
    {
        instance_destroy(obj_fadeout);

        with (instance_create(0, 0, obj_fadein))
            fadespeed = -0.16;
    }
}