/// IMPORT

function array_find_index_temp(array, check_function)
{
    var len = array_length(array);

    for (var i = 0; i < len; i++)
    {
        if (check_function(array[i], i))
            return i;
    }

    return -1;
}

function scr_is_fow_starting_goal(name)
{
    name = string_lower(name);

    for (var i = 0; i < global.fog_of_war; i++)
    {
        var len = array_length(global.srl_goals[i]);

        for (var j = 0; j < len; j++)
        {
            if (global.srl_goals[i][j] == name)
                return true;
        }
    }

    return false;
}

function scr_bingo_paused()
{
    return (global.chat_typing || global.starring_goals || instance_exists(obj_bingo_settings_screen) || instance_exists(obj_fullscreen_fadeout));
}

function scr_pad_zero(value, amount)
{
    var s = string(value);

    while (string_length(s) < amount)
        s = "0" + s;

    return s;
}

function scr_format_seconds(amount)
{
    amount = max(0, round(amount));
    var days = amount div 86400;
    var hours = (amount % 86400) div 3600;
    var minutes = (amount % 3600) div 60;
    var seconds = amount % 60;
    var str = scr_pad_zero(minutes, 2) + ":" + scr_pad_zero(seconds, 2);

    if (days > 0)
        str = string(days) + ":" + scr_pad_zero(hours, 2) + ":" + str;
    else if (hours > 0)
        str = string(hours) + ":" + str;

    return str;
}

function scr_get_temp_draw()
{
    temp_halign = draw_get_halign();
    temp_valign = draw_get_valign();
    temp_font = draw_get_font();
    temp_alpha = draw_get_alpha();
    temp_color = draw_get_color();
}

function scr_set_temp_draw()
{
    draw_set_halign(temp_halign);
    draw_set_valign(temp_valign);
    draw_set_font(temp_font);
    draw_set_alpha(temp_alpha);
    draw_set_color(temp_color);
}

function ossafe_http_get(url)
{
    if (global.is_console)
        return http_request(url, "GET", global.cookie_sessionid, "");
    else
        return http_get(url);
}

function ossafe_http_post(url, body)
{
    if (global.is_console)
        return http_request(url, "POST", global.cookie_sessionid, body);
    else
        return http_post_string(url, body);
}

function ossafe_keyboard_lastkey()
{
    if (!keyboard_check_pressed(vk_anykey))
        return vk_nokey;

    // keyboard_lastkey doesn't update on consoles
    if (global.is_console)
    {
        for (var i = 2; i < 256; i++)
        {
            if (keyboard_check_pressed(i))
                return i;
        }

        return vk_nokey;
    }
    else
    {
        return keyboard_lastkey;
    }
}

function scr_gamepad_lastkey()
{
    if (!instance_exists(obj_gamecontroller))
    {
        return 0;
    }
    else if (obj_gamecontroller.gamepad_active)
    {
        // gp_face1 - gp_padr
        for (var i = 32769; i <= 32784; i++)
        {
            if (gamepad_button_check_pressed(obj_gamecontroller.gamepad_id, i))
                return i;
        }
        // Skip axes
        // gp_home - gp_extra6
        for (var i = 32799; i <= 32810; i++)
        {
            if (gamepad_button_check_pressed(obj_gamecontroller.gamepad_id, i))
                return i;
        }
    }

    return 0;
}

// This function already exists in Chapter 2+ but we have to add it for Chapter 1
#if CHAPTER_1
function draw_text_outline(text_x, text_y, text, outline_color = c_black)
{
    var reset_color = draw_get_color();
    draw_set_color(outline_color);
    var dirs = [
        [-1, 0],  [1, 0],
        [0, -1],  [0, 1],
        [-1, -1], [1, -1],
        [-1, 1],  [1, 1]
    ];

    for (var i = 0; i < array_length(dirs); i++)
        draw_text(text_x + dirs[i][0], text_y + dirs[i][1], text);

    draw_set_color(reset_color);
    draw_text(text_x, text_y, text);
}
#endif

function draw_text_outline_ext(text_x, text_y, text, text_sep, text_w, outline_color = c_black)
{
    var reset_color = draw_get_color();
    draw_set_color(outline_color);
    var dirs = [
        [-1, 0],  [1, 0],
        [0, -1],  [0, 1],
        [-1, -1], [1, -1],
        [-1, 1],  [1, 1]
    ];

    for (var i = 0; i < array_length(dirs); i++)
        draw_text_ext(text_x + dirs[i][0], text_y + dirs[i][1], text, text_sep, text_w);

    draw_set_color(reset_color);
    draw_text_ext(text_x, text_y, text, text_sep, text_w);
}

function draw_text_outline_ext_transformed(text_x, text_y, text, text_sep, text_w, xscale, yscale, text_angle, outline_color = c_black)
{
    var reset_color = draw_get_color();
    draw_set_color(outline_color);
    var cos_r = dcos(text_angle);
    var sin_r = dsin(text_angle);
    var dirs = [
        [-xscale, 0],       [xscale, 0],
        [0, -yscale],       [0, yscale],
        [-xscale, -yscale], [xscale, -yscale],
        [-xscale, yscale],  [xscale, yscale]
    ];

    for (var i = 0; i < array_length(dirs); i++)
        draw_text_ext_transformed(text_x + ((dirs[i][0] * cos_r) - (dirs[i][1] * sin_r)), text_y + ((dirs[i][0] * sin_r) + (dirs[i][1] * cos_r)), text, text_sep, text_w, xscale, yscale, text_angle);

    draw_set_color(reset_color);
    draw_text_ext_transformed(text_x, text_y, text, text_sep, text_w, xscale, yscale, text_angle);
}

function scr_input_name(input)
{
    switch (input)
    {
        case 8:   return "BACKSPACE";
        case 9:   return "TAB";
        case 12:  return "NUM 5 (NUM LOCK OFF)";
        case 13:  return "ENTER";
        case 16:  return "SHIFT";
        case 17:  return "CONTROL";
        case 18:  return "ALT";
        case 19:  return "PAUSE";
        case 20:  return "CAPS LOCK";
        case 27:  return "ESCAPE";
        case 32:  return "SPACE";
        case 33:  return "PAGE UP";
        case 34:  return "PAGE DOWN";
        case 35:  return "END";
        case 36:  return "HOME";
        case 37:  return "LEFT";
        case 38:  return "UP";
        case 39:  return "RIGHT";
        case 40:  return "DOWN";
        case 44:  return "PRINT SCREEN";
        case 45:  return "INSERT";
        case 46:  return "DELETE";
        case 91:  return "WINDOWS KEY";
        case 92:  return "RIGHT WINDOWS KEY";
        case 93:  return "CONTEXT MENU";
        case 96:  return "NUM 0";
        case 97:  return "NUM 1";
        case 98:  return "NUM 2";
        case 99:  return "NUM 3";
        case 100: return "NUM 4";
        case 101: return "NUM 5 (NUM LOCK ON)";
        case 102: return "NUM 6";
        case 103: return "NUM 7";
        case 104: return "NUM 8";
        case 105: return "NUM 9";
        case 106: return "NUM *";
        case 107: return "NUM +";
        case 109: return "NUM -";
        case 110: return "NUM .";
        case 111: return "NUM /";
        case 112: return "F1";
        case 113: return "F2";
        case 114: return "F3";
        case 115: return "F4";
        case 116: return "F5";
        case 117: return "F6";
        case 118: return "F7";
        case 119: return "F8";
        case 120: return "F9";
        case 121: return "F10";
        case 122: return "F11";
        case 123: return "F12";
        case 144: return "NUM LOCK";
        case 145: return "SCROLL LOCK";
        case 160: return "LEFT SHIFT";
        case 161: return "RIGHT SHIFT";
        case 162: return "LEFT CONTROL";
        case 163: return "RIGHT CONTROL";
        case 164: return "LEFT ALT";
        case 165: return "RIGHT ALT";
        case 186: return ";";
        case 187: return "=";
        case 188: return ",";
        case 189: return "-";
        case 190: return ".";
        case 191: return "/";
        case 192: return "TILDE";
        case 219: return "[";
        case 220: return "\\";
        case 221: return "]";
        case 222: return "APOSTROPHE";
        default:  return chr(input);
    }
}

function scr_input_name_gp(input)
{
    switch (input)
    {
        case gp_home:           return "[HOME]";
        case gp_touchpadbutton: return "[TOUCHPAD]";
        case gp_paddler:        return "[PADDLE 1]";
        case gp_paddlerb:       return "[PADDLE 2]";
        case gp_paddlel:        return "[PADDLE 3]";
        case gp_paddlelb:       return "[PADDLE 4]";
        case gp_extra1:         return "[EXTRA 1]";
        case gp_extra2:         return "[EXTRA 2]";
        case gp_extra3:         return "[EXTRA 3]";
        case gp_extra4:         return "[EXTRA 4]";
        case gp_extra5:         return "[EXTRA 5]";
        case gp_extra6:         return "[EXTRA 6]";
        default:                return scr_getbuttonsprite(input, false);
    }
}

function scr_check_pressed(kb_key, gp_key)
{
    if (keyboard_check_pressed(kb_key))
        return true;

    if (instance_exists(obj_gamecontroller))
    {
        if (obj_gamecontroller.gamepad_active && gamepad_button_check_pressed(obj_gamecontroller.gamepad_id, gp_key))
            return true;
    }

    return false;
}

function scr_check_held(kb_key, gp_key)
{
    if (keyboard_check(kb_key))
        return true;

    if (instance_exists(obj_gamecontroller))
    {
        if (obj_gamecontroller.gamepad_active && gamepad_button_check(obj_gamecontroller.gamepad_id, gp_key))
            return true;
    }

    return false;
}

function scr_check_mouse_pressed(mb_key, gp_key)
{
    if (mouse_check_button_pressed(mb_key))
        return true;

    if (instance_exists(obj_gamecontroller))
    {
        if (obj_gamecontroller.gamepad_active && gamepad_button_check_pressed(obj_gamecontroller.gamepad_id, gp_key))
            return true;
    }

    return false;
}

function scr_show_mouse_at(_x, _y)
{
    obj_time.mousex = _x;
    obj_time.mousey = _y;
    obj_time.mouse_visible = true;
    window_mouse_set(_x, _y);
}

function scr_escape_string(str)
{
    var escaped = "";
    var character = "";

    for (var i = 1; i <= string_length(str); i++)
    {
        character = string_char_at(str, i);

        switch (character)
        {
            case "\"":
                escaped += "\\\"";
                break;

            case "\\":
                escaped += "\\\\";
                break;

            default:
                escaped += character;
                break;
        }
    }

    return escaped;
}

function scr_html_decode(str)
{
    str = string_replace_all(str, "&lt;", "<");
    str = string_replace_all(str, "&gt;", ">");
    str = string_replace_all(str, "&amp;", "&");
    str = string_replace_all(str, "&quot;", "\"");
    str = string_replace_all(str, "&#x27;", "'");
    return str;
}

function scr_color_from_name(color_str)
{
    switch (color_str)
    {
        case "blank":  return c_gray;
        case "green":  return 0x62C462;
        case "red":    return 0x5B5FEE;
        case "orange": return 0x0694F8;
        case "blue":   return 0xDEC05B;
        case "purple": return 0xBF2D82;
        case "navy":   return 0xB5480D;
        case "teal":   return 0x959641;
        case "pink":   return 0x9C79DE;
        case "brown":  return 0x235CAB;
        case "yellow": return 0x0BBAC1;
        default:       return c_white;
    }
}

function scr_chat_message(msg_color, msg_text)
{
    var len = array_length(global.chat_line) - 1;
    var i = 0;
    var new_lines = 0;

    while (string_width_ext(msg_text, 15, 330) >= 330)
    {
        new_lines++;
        msg_text = string_insert("\n", msg_text, (50 - new_lines) * new_lines);

        if (new_lines >= 5)
            break;
    }

    msg_text = string_trim(msg_text);

    if (global.chat_line[len] == "")
    {
        for (i = 0; i <= len; i++)
        {
            if (global.chat_line[i] == "")
            {
                global.chat_color[i] = msg_color;
                global.chat_line[i] = msg_text;
                exit;
            }
        }
    }

    for (i = 0; i < len; i++)
    {
        global.chat_color[i] = global.chat_color[i + 1];
        global.chat_line[i] = global.chat_line[i + 1];
    }

    global.chat_color[len] = msg_color;
    global.chat_line[len] = msg_text;
}

function scr_is_goal_marked(slot)
{
    return string_pos(global.color, global.goal_colors[slot]) > 0;
}

function scr_is_goal_visible(slot)
{
    if (global.fog_of_war == 0 || scr_is_goal_marked(slot) || scr_is_fow_starting_goal(global.goal_name[slot]))
        return true;

    if (slot >= 5 && scr_is_goal_marked(slot - 5))
        return true;

    if ((slot % 5) != 4 && scr_is_goal_marked(slot + 1))
        return true;

    if (slot < 20 && scr_is_goal_marked(slot + 5))
        return true;

    if ((slot % 5) != 0 && scr_is_goal_marked(slot - 1))
        return true;

    return false;
}

function scr_load_bingo_data()
{
    global.prev_hits = 0;
    global.room_id = "";
    global.password = "";
    global.nickname = "";
    global.color = "";
    global.last_card_timestamp = 0;
    global.last_connected_room = "";
    global.hits = 0;
    global.queued_goals = array_create(25, false);
    global.hit_counter = false;
    global.show_board = true;
    global.board_key = ord("B");
    global.chat_key = ord("T");
    global.reveal_key = ord("R");
    global.toggle_chat_key = ord("Y");
    global.color_hide_key = ord("G");
    global.board_key_gp = gp_face3;
    global.chat_key_gp = gp_shoulderl;
    global.reveal_key_gp = gp_start;
    global.toggle_chat_key_gp = gp_select;
    global.color_hide_key_gp = gp_shoulderr;
    global.show_connections = true;
    global.show_reveals = true;
    global.show_chats = true;
    global.show_colors = true;
    global.show_goal_marks = true;
    global.show_new_cards = true;
    global.hit_counter = false;
    global.show_other_colors = true;
    global.fog_of_war = 0;
    global.room_history = [];

    if (file_exists(#GetBingoFile()))
    {
        var file = file_text_open_read(#GetBingoFile());
        var json = json_parse(file_text_read_string(file));
        file_text_close(file);

        if (variable_struct_exists(json, "room_history"))
            global.room_history = json.room_history;

        if (variable_struct_exists(json, "last_saved_room"))
        {
            if (variable_struct_exists(json.last_saved_room, "room_id"))
                global.room_id = string_copy(scr_escape_string(string_trim(json.last_saved_room.room_id)), 1, 22);

            if (variable_struct_exists(json.last_saved_room, "password"))
                global.password = scr_escape_string(json.last_saved_room.password);

            if (variable_struct_exists(json.last_saved_room, "nickname"))
                global.nickname = string_copy(scr_escape_string(string_trim(json.last_saved_room.nickname)), 1, 50);

            if (variable_struct_exists(json.last_saved_room, "color"))
            {
                global.color = string_lower(string_trim(json.last_saved_room.color));

                if (global.color == "blank" || scr_color_from_name(global.color) == c_white)
                    global.color = "";
            }

            if (variable_struct_exists(json.last_saved_room, "starred_goals")) global.starred_goals = json.last_saved_room.starred_goals;
            if (variable_struct_exists(json.last_saved_room, "last_card_timestamp")) global.last_card_timestamp = json.last_saved_room.last_card_timestamp;
            if (variable_struct_exists(json.last_saved_room, "last_connected_room")) global.last_connected_room = json.last_saved_room.last_connected_room;
        }

        if (variable_struct_exists(json, "preferences"))
        {   
            if (variable_struct_exists(json.preferences, "hit_counter")) global.hit_counter = json.preferences.hit_counter;
            if (variable_struct_exists(json.preferences, "show_chat")) global.show_chat = json.preferences.show_chat;
            if (variable_struct_exists(json.preferences, "show_board")) global.show_board = json.preferences.show_board;
            if (variable_struct_exists(json.preferences, "show_other_colors")) global.show_other_colors = json.preferences.show_other_colors;
            if (variable_struct_exists(json.preferences, "fog_of_war")) global.fog_of_war = clamp(json.preferences.fog_of_war, 0, 24);
        }

        if (variable_struct_exists(json, "keybinds"))
        {
            if (variable_struct_exists(json.keybinds, "board")) global.board_key = json.keybinds.board;
            if (variable_struct_exists(json.keybinds, "chat")) global.chat_key = json.keybinds.chat;
            if (variable_struct_exists(json.keybinds, "reveal")) global.reveal_key = json.keybinds.reveal;
            if (variable_struct_exists(json.keybinds, "toggle_chat")) global.toggle_chat_key = json.keybinds.toggle_chat;
            if (variable_struct_exists(json.keybinds, "color_hide")) global.color_hide_key = json.keybinds.color_hide;
            if (variable_struct_exists(json.keybinds, "board_gp")) global.board_key_gp = json.keybinds.board_gp;
            if (variable_struct_exists(json.keybinds, "chat_gp")) global.chat_key_gp = json.keybinds.chat_gp;
            if (variable_struct_exists(json.keybinds, "reveal_gp")) global.reveal_key_gp = json.keybinds.reveal_gp;
            if (variable_struct_exists(json.keybinds, "toggle_chat_gp")) global.toggle_chat_key_gp = json.keybinds.toggle_chat_gp;
            if (variable_struct_exists(json.keybinds, "color_hide_gp")) global.color_hide_key_gp = json.keybinds.color_hide_gp;
        }

        if (variable_struct_exists(json, "filters"))
        {
            if (variable_struct_exists(json.filters, "connections")) global.show_connections = json.filters.connections;
            if (variable_struct_exists(json.filters, "reveals")) global.show_reveals = json.filters.reveals;
            if (variable_struct_exists(json.filters, "chats")) global.show_chats = json.filters.chats;
            if (variable_struct_exists(json.filters, "colors")) global.show_colors = json.filters.colors;
            if (variable_struct_exists(json.filters, "goal_marks")) global.show_goal_marks = json.filters.goal_marks;
            if (variable_struct_exists(json.filters, "new_cards")) global.show_new_cards = json.filters.new_cards;
        }

        if (variable_struct_exists(json, "progress"))
        {
            if (variable_struct_exists(json.progress, "hits")) global.hits = json.progress.hits;
            if (variable_struct_exists(json.progress, "queued_goals")) global.queued_goals = json.progress.queued_goals;

            var list = ds_list_create();

            if (variable_struct_exists(json.progress, "general"))
            {
                ds_list_read(list, json.progress.general);
                var size = ds_list_size(list);
                var value = 0;

                for (var i = 0; i < size; i++)
                {
                    value = ds_list_find_value(list, i);
                    global.goal_progress[i] = is_undefined(value) ? 0 : value;
                }
            }

            for (var i = 0; i < array_length(global.goal_custom_vars); i++)
            {
                if (variable_struct_exists(json.progress, global.goal_custom_vars[i].name))
                {
                    ds_list_read(list, variable_struct_get(json.progress, global.goal_custom_vars[i].name));
                    var size = ds_list_size(list);
                    var value = 0;

                    for (var j = 0; j < size; j++)
                    {
                        value = ds_list_find_value(list, j);
                        array_set(variable_global_get(global.goal_custom_vars[i].name), j, is_undefined(value) ? "" : value);
                    }
                }
            }

            ds_list_destroy(list);
        }
    }
}

function scr_save_bingo_data()
{
    var list = ds_list_create();
    var file = file_text_open_write(#GetBingoFile());
    var data = {};
    data.room_history = global.room_history;
    data.last_saved_room = {};
    data.preferences = {};
    data.keybinds = {};
    data.filters = {};
    data.progress = {};
    data.last_saved_room.room_id = global.room_id;
    data.last_saved_room.password = global.password;
    data.last_saved_room.nickname = global.nickname;
    data.last_saved_room.color = global.color;
    data.last_saved_room.starred_goals = global.starred_goals;
    data.last_saved_room.last_card_timestamp = global.last_card_timestamp;
    data.last_saved_room.last_connected_room = global.last_connected_room;
    data.preferences.hit_counter = global.hit_counter;
    data.preferences.show_chat = global.show_chat;
    data.preferences.show_board = global.show_board;
    data.preferences.autoconnect = global.autoconnect;
    data.preferences.show_other_colors = global.show_other_colors;
    data.preferences.fog_of_war = global.fog_of_war;
    data.keybinds.board = global.board_key;
    data.keybinds.chat = global.chat_key;
    data.keybinds.reveal = global.reveal_key;
    data.keybinds.toggle_chat = global.toggle_chat_key;
    data.keybinds.color_hide = global.color_hide_key;
    data.keybinds.board_gp = global.board_key_gp;
    data.keybinds.chat_gp = global.chat_key_gp;
    data.keybinds.reveal_gp = global.reveal_key_gp;
    data.keybinds.toggle_chat_gp = global.toggle_chat_key_gp;
    data.keybinds.color_hide_gp = global.color_hide_key_gp;
    data.filters.connections = global.show_connections;
    data.filters.reveals = global.show_reveals;
    data.filters.chats = global.show_chats;
    data.filters.colors = global.show_colors;
    data.filters.goal_marks = global.show_goal_marks;
    data.filters.new_cards = global.show_new_cards;
    data.progress.hits = global.hits;
    data.progress.queued_goals = global.queued_goals;

    for (var i = 0; i < array_length(global.goal_progress); i++)
        ds_list_add(list, global.goal_progress[i]);
    data.progress.general = ds_list_write(list);

    for (var i = 0; i < array_length(global.goal_custom_vars); i++)
    {
        ds_list_clear(list);

        for (var j = 0; j < global.goal_custom_vars[i].size; j++)
            ds_list_add(list, array_get(variable_global_get(global.goal_custom_vars[i].name), j));

        variable_struct_set(data.progress, global.goal_custom_vars[i].name, ds_list_write(list));
    }

    ds_list_destroy(list);
    file_text_write_string(file, json_stringify(data));
    file_text_close(file);

    if (scr_is_switch_os())
        switch_save_data_commit();
}

function scr_reset_bingo_data()
{
    global.goal_progress = array_create(global.num_goals, 0);
    global.starred_goals = array_create(25, false);
    global.queued_goals = array_create(25, false);
    global.hits = 0;

    for (var i = 0; i < array_length(global.goal_custom_vars); i++)
        variable_global_set(global.goal_custom_vars[i].name, array_create(global.goal_custom_vars[i].size, ""));

    scr_save_bingo_data();
}

function scr_goal_slot_from_name(name)
{
    name = string_lower(string_trim(name));

    for (var i = 0; i < 25; i++)
    {
        if (string_lower(global.goal_name[i]) == name)
            return real(string_digits(global.goal_slot[i]));
    }

    return 0;
}

function scr_mark_goal(slot)
{
    if (slot > 0 && !scr_is_goal_marked(slot - 1))
    {
        // Prevent goals from triggering multiple times in quick succession
        if (global.goal_colors[slot - 1] == "blank")
        {
            global.goal_colors[slot - 1] = global.color;
        }
        // Prevent your color from showing up when you mark a taken goal with Lockout enabled.
        // Also sort the colors in alphabetical order just like how Bingosync stores them
        else if (global.room_lockout == "Non-Lockout")
        {
            var color_array = string_split(global.goal_colors[slot - 1] + " " + global.color, " ", true);
            array_sort(color_array, true);
            global.goal_colors[slot - 1] = "";

            for (var i = 0; i < array_length(color_array); i++)
                global.goal_colors[slot - 1] += color_array[i] + " ";
        }

        with (obj_bingo_controller)
        {
            update_colors = false;
            alarm[0] = 3 * room_speed;
        }

        ossafe_http_post("https://bingosync.com/api/select", "{ \"room\": \"" + global.room_id + "\", \"color\": \"" + global.color + "\", \"slot\": \"" + string(slot) + "\", \"remove_color\": false }");
    }
}

function scr_goal_requirements(slot)
{
    if (slot < 0 || slot >= global.num_goals)
        return false;

    return global.goal_progress[slot] >= global.goal_list[slot].max_progress;
}

function scr_add_goal_array(slot, str)
{
    if (global.ws_client == -1)
        exit;

    var var_index = ds_map_find_value(global.goal_vars_indexes, string_lower(global.goal_list[slot].name));

    if (is_undefined(var_index))
        exit;

    var arr_name = global.goal_custom_vars[var_index].name;
    var len = global.goal_custom_vars[var_index].size;
    var value = "";

    for (var i = 0; i < len; i++)
    {
        value = array_get(variable_global_get(arr_name), i);

        if (value == str)
        {
            exit;
        }
        else if (value == "")
        {
            array_set(variable_global_get(arr_name), i, str);

            if (i == (len - 1))
                scr_add_goal_progress(slot, 1);
            else
                scr_save_bingo_data();

            exit;
        }
    }
}

function scr_add_goal_spares(amount, include_pacify_only = false)
{
    scr_add_goal_progress(10, amount);
    scr_add_goal_progress(30, amount);

    if (include_pacify_only)
    {
        scr_add_goal_progress(2, amount);
        scr_add_goal_progress(80, amount);
    }
}

function scr_add_goal_kills(amount)
{
    scr_add_goal_progress(3, amount);
    scr_add_goal_progress(16, amount);
    scr_add_goal_progress(31, amount);    
}

#if CHAPTER_5
function scr_add_goal_pink_coin()
{
    for (var i = 145; i <= 147; i++)
        scr_add_goal_array(i, room_get_name(room));
}
#endif

function scr_add_goal_buy()
{
    if (global.buy_frame_delay != -1)
        exit;

    with (obj_bingo_controller)
    {
        buy_update_money_amount = global.gold;
    #if CHAPTER_3
        buy_update_points_amount = global.flag[1044];
    #elsif CHAPTER_5
        buy_update_flowery_money_amount = global.flag[1411];
    #endif
    }

    global.buy_frame_delay = call_later(1, time_source_units_frames, function()
    {
        with (obj_bingo_controller)
        {
            if (global.gold < buy_update_money_amount
            #if CHAPTER_3
                || global.flag[1044] < buy_update_points_amount
            #elsif CHAPTER_5
                || global.flag[1411] < buy_update_flowery_money_amount
            #endif
                )
                scr_add_goal_array(8, room_get_name(room));
        }

        global.buy_frame_delay = -1;
    });
}

function scr_add_goal_progress(slot, amount)
{
    if (global.ws_client == -1)
        exit;

    global.goal_progress[slot] += amount;

    if (scr_goal_requirements(slot))
    {
        var board_slot = scr_goal_slot_from_name(global.goal_list[slot].name);

        if (board_slot > 0)
        {
            if (scr_is_goal_visible(board_slot - 1))
                scr_mark_goal(board_slot);
            else
                global.queued_goals[board_slot - 1] = true;
        }
    }

    scr_save_bingo_data();
}

function scr_add_hit()
{   
#if CHAPTER_2
    if (room == room_dw_mansion_b_west_2f && !global.teacupshit)
    {
        global.teacupshit = true;
        global.hits++;
        scr_save_bingo_data();
    }
    else if (room != room_dw_mansion_b_west_2f)
#elsif CHAPTER_3
    if (instance_exists(obj_tenna_enemy) && instance_exists(obj_elnina_umbrella) && !obj_tenna_enemy.minigameinsanitydamage)
        exit;

    if (instance_exists(obj_knight_enemy) && instance_exists(obj_sword_tunnel_manager) && obj_sword_tunnel_manager.con == 0 && !global.knight_swords_hit)
    {
        global.knight_swords_hit = true;
        global.hits++;
        scr_save_bingo_data();
    }
    else if (!global.knight_swords_hit)
#elsif CHAPTER_4
    if (global.forcedswords || (instance_exists(obj_ghosthouse_jackolantern) && obj_ghosthouse_jackolantern.hits > 1))
        exit;
#endif

    // The idea here is when you get hit, wait a frame to see the difference in hits
    // and if it's greater than 1, only count 1.
    // There's no point where more than 1 hit should intentionally count.
    if (global.hits_frame_delay == -1)
    {
        global.prev_hits = global.hits;
        global.hits_frame_delay = call_later(1, time_source_units_frames, function()
        {
            global.hits = global.prev_hits + 1;
            global.hits_frame_delay = -1;
            scr_save_bingo_data();
        });
    }
}