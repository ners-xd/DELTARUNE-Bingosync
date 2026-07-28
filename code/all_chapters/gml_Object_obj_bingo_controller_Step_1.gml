/// IMPORT

if (!board_done || !room_settings_done || !feed_done || !room_base_done)
    exit;

var timestamp_offset = (global.last_card_timestamp == 0) ? (0) : (global.start_timestamp - (global.last_card_timestamp * 1000));
var timezone = date_get_timezone();
date_set_timezone(timezone_utc);
current_board_time = scr_format_ms(current_time - global.start_current_time + timestamp_offset);
date_set_timezone(timezone);

if (room == ROOM_INITIALIZE && instance_exists(obj_initializer2))
{
    with (obj_fullscreen_fadeout)
        instance_destroy();

    room_goto(obj_initializer2.roomchoice);
    exit;
}

if (!scr_bingo_paused())
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
            keyboard_string = "";
            keyboard_clear(global.chat_key);

            if (global.console_keyboard)
            {
                mystring = "";
                console_string = get_string_async("Typing in chat. Commands: " + command_list + ".", "");
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

                chat_history = init_chat_history;
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
            ossafe_http_post("https://bingosync.com/api/revealed", "{ \"room\": \"" + scr_escape_string(global.room_id) + "\" }");
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

        global.chat_typing = false;
        global.starring_goals = false;
        obj_time.mouse_visible = false;
        chat_history = [];
        chat_history_index = -1;
        keyboard_clear(vk_escape);
    }
}

if (global.gold != money_amount)
{
    if (global.gold >= 5000)
        scr_add_goal_progress(0, 1);

    if (global.gold >= 3000)
        scr_add_goal_progress(22, 1);

    money_amount = global.gold;
}

#if CHAPTER_5
if (global.flag[1411] != flowery_money_amount)
{
    if (global.flag[1411] >= 250)
        scr_add_goal_progress(153, 1);

    flowery_money_amount = global.flag[1411];
}
#endif

#if CHAPTER_4 || CHAPTER_5
if (jack_playing != noone)
{
    if (!audio_is_playing(jack_sfx[jack_playing]))
        jack_playing = noone;
}
else
{
    for (var i = 0; i < jack_sfx_len; i++)
    {
        if (audio_is_playing(jack_sfx[i]))
        {
            jack_playing = i;
            scr_add_goal_progress(173, 1);
            break;
        }
    }
}
#endif

var save = false;

for (var i = 0; i < 25; i++)
{
    if (global.queued_goals[i] && scr_is_goal_visible(i))
    {
        global.queued_goals[i] = false;
        scr_mark_goal(i + 1);
        save = true;
    }
}

if (save)
    scr_save_bingo_data();