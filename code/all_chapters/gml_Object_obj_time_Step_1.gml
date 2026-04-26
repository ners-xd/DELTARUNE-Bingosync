/// PATCH

/// PREPEND
internet = os_is_network_connected();

if (internet)
{
    if (goal_list_request == -1)
        goal_list_request = http_get("https://raw.githubusercontent.com/ners-xd/deltarune-bingosync/refs/heads/" + scr_get_branch_name() + "/assets/goal_list.json");

    if (srl_list_request == -1)
        srl_list_request = http_get("https://raw.githubusercontent.com/ners-xd/deltarune-bingosync/refs/heads/" + scr_get_branch_name() + "/assets/goal_list_srl_format.json");

    if (update_check_request == -1)
        update_check_request = http_get("https://api.github.com/repos/ners-xd/deltarune-bingosync/releases/latest");
}

if (mouse_visible)
{
    var lh = 0;
    var lv = 0;
    var sw = surface_get_width(application_surface);
    var sh = surface_get_height(application_surface);
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    if (instance_exists(obj_gamecontroller) && obj_gamecontroller.gamepad_active)
    {
        lh = gamepad_axis_value(obj_gamecontroller.gamepad_id, gp_axislh) * 20;
        lv = gamepad_axis_value(obj_gamecontroller.gamepad_id, gp_axislv) * 20;
    }

    if (lh != 0 || lv != 0)
    {
        controller_used = true;
    }
    else if (mx != last_mouse_x || my != last_mouse_y)
    {
        if (controller_used)
        {
            controller_offset_x = 0;
            controller_offset_y = 0;
        }
        
        controller_used = false;
    }

    if (controller_used)
    {
        mousex = clamp(mousex + lh, 0, sw);
        mousey = clamp(mousey + lv, 0, sh);
        controller_offset_x = clamp(controller_offset_x + lh, -sw, sw);
        controller_offset_y = clamp(controller_offset_y + lv, -sh, sh);
    }
    else
    {
        mousex = mx + controller_offset_x;
        mousey = my + controller_offset_y;
    }

    last_mouse_x = mx;
    last_mouse_y = my;
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