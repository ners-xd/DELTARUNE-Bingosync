/// PATCH

/// PREPEND
internet = os_is_network_connected();

if (internet)
{
    if (goal_list_request == -1)
        goal_list_request = http_get("https://raw.githubusercontent.com/ners-xd/deltarune-bingosync/refs/heads/ch1-4/assets/goal_list.json");
    
    if (update_check_request == -1)
        update_check_request = http_get("https://api.github.com/repos/ners-xd/deltarune-bingosync/releases/latest");
}

if (mouse_visible)
{
    mousex = window_mouse_get_x();
    mousey = window_mouse_get_y();

    if (instance_exists(obj_gamecontroller) && obj_gamecontroller.gamepad_active)
    {
        var lh = gamepad_axis_value(obj_gamecontroller.gamepad_id, gp_axislh) * 20;
        var lv = gamepad_axis_value(obj_gamecontroller.gamepad_id, gp_axislv) * 20;

        if (lh != 0 || lv != 0)
        {
            mousex += lh;
            mousey += lv;
            window_mouse_set(mousex, mousey);
        }
    }
}
/// END

/// BEFORE
#if CHAPTER_1
if (obj_gamecontroller.gamepad_active == 1)
#else
if (obj_gamecontroller.gamepad_active == 1 && quicksaved != 2)
#endif
/// CODE
if (!global.chat_typing && !global.starring_goals)
{
    if (room != ROOM_INITIALIZE && scr_check_pressed(global.toggle_chat_key, global.toggle_chat_key_gp))
    {
        global.show_chat = !global.show_chat;
        scr_save_bingo_data();
    }
/// END

/// BEFORE
#if CHAPTER_1
if (border_fade_out)
#else
    }
}

if (scr_debug())
#endif
/// CODE
}
/// END