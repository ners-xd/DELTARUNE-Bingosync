/// IMPORT

if (!board_connected)
    exit;

if (!global.chat_typing && !global.starring_goals)
{
    if (scr_check_pressed(global.board_key, global.board_key_gp))
    {
        global.show_board = !global.show_board;
        scr_save_bingo_data();
    }
    else if (scr_check_pressed(global.chat_key, global.chat_key_gp))
    {
        if (keyboard_check(vk_control) || keyboard_check(vk_shift))
        {
            scr_chat_message(c_red, "You can't open the chat with CONTROL or SHIFT held.");
        }
        else
        {
            global.chat_typing = true;

            if (global.is_console)
            {
                mystring = "";
                console_string = get_string_async("Typing in chat. Commands: /color, /star, /autoconnect.", "");
            }
            else
            {
                for (var i = 0; i < 10; i += 1)
                {
                    if (global.input_held[i] || global.input_pressed[i])
                        global.input_released[i] = 1;

                    global.input_held[i] = 0;
                    global.input_pressed[i] = 0;
                }

                keyboard_string = "";
            }
        }
    }
    else if (scr_check_pressed(global.reveal_key, global.reveal_key_gp))
    {
        if (board_revealed)
        {
            scr_chat_message(c_red, "The card is already revealed.");
        }
        else
        {
            board_revealed = true;
            ossafe_http_post("https://bingosync.com/api/revealed", "{ \"room\": \"" + global.room_id + "\" }");
        }
    }
    else if (scr_check_pressed(global.color_hide_key, global.color_hide_key_gp))
    {
        global.show_other_colors = !global.show_other_colors;
        scr_save_bingo_data();
    }
}
else if (scr_check_pressed(vk_escape, global.input_g[5]))
{
    global.chat_typing = false;
    global.starring_goals = false;
    obj_time.mouse_visible = false;
    keyboard_string = "";
    keyboard_clear(vk_escape);
}