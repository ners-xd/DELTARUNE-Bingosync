/// IMPORT

function scr_get_mod_version()
{
    /* todo after tournament group stage finishes
    change some goal names for clarity (ultimate heal, specify chapters for donate d$1 and get 2 gold items, clarify "item" for get pipis, clarify "consumables" for full inventory etc)
    push "tell jackenstein he's cute" into goal list
    bump to 2.15
    */
    return "2.14";
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
function draw_text_outline(text_x, text_y, text, text_color = c_black)
{
    var reset_color = draw_get_color();
    draw_set_color(text_color);
    draw_text(text_x - 1, text_y, text);
    draw_text(text_x - 1, text_y - 1, text);
    draw_text(text_x - 1, text_y + 1, text);
    draw_text(text_x + 1, text_y, text);
    draw_text(text_x + 1, text_y + 1, text);
    draw_text(text_x + 1, text_y - 1, text);
    draw_text(text_x, text_y + 1, text);
    draw_text(text_x, text_y - 1, text);
    draw_set_color(reset_color);
    draw_text(text_x, text_y, text);
}
#endif

function draw_text_outline_ext(text_x, text_y, text, text_sep, text_w, text_color = c_black)
{
    var reset_color = draw_get_color();
    draw_set_color(text_color);
    draw_text_ext(text_x - 1, text_y, text, text_sep, text_w);
    draw_text_ext(text_x - 1, text_y - 1, text, text_sep, text_w);
    draw_text_ext(text_x - 1, text_y + 1, text, text_sep, text_w);
    draw_text_ext(text_x + 1, text_y, text, text_sep, text_w);
    draw_text_ext(text_x + 1, text_y + 1, text, text_sep, text_w);
    draw_text_ext(text_x + 1, text_y - 1, text, text_sep, text_w);
    draw_text_ext(text_x, text_y + 1, text, text_sep, text_w);
    draw_text_ext(text_x, text_y - 1, text, text_sep, text_w);
    draw_set_color(reset_color);
    draw_text_ext(text_x, text_y, text, text_sep, text_w);
}

function draw_text_outline_ext_transformed(text_x, text_y, text, text_sep, text_w, text_xscale, text_yscale, text_angle, text_color = c_black)
{
    var reset_color = draw_get_color();
    draw_set_color(text_color);
    draw_text_ext_transformed(text_x - 1, text_y, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
    draw_text_ext_transformed(text_x - 1, text_y - 1, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
    draw_text_ext_transformed(text_x - 1, text_y + 1, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
    draw_text_ext_transformed(text_x + 1, text_y, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
    draw_text_ext_transformed(text_x + 1, text_y + 1, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
    draw_text_ext_transformed(text_x + 1, text_y - 1, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
    draw_text_ext_transformed(text_x, text_y + 1, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
    draw_text_ext_transformed(text_x, text_y - 1, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
    draw_set_color(reset_color);
    draw_text_ext_transformed(text_x, text_y, text, text_sep, text_w, text_xscale, text_yscale, text_angle);
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

function scr_check_mouse_pressed(mb_key, gp_key)
{
    if (device_mouse_check_button_pressed(0, mb_key))
        return true;

    if (instance_exists(obj_gamecontroller))
    {
        if (obj_gamecontroller.gamepad_active && gamepad_button_check_pressed(obj_gamecontroller.gamepad_id, gp_key))
            return true;
    }

    return false;
}

function scr_escape_string(str)
{
    str = string_trim(str);
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

function scr_ds_list_to_array(list, key)
{
    ds_list_read(list, key);
    var size = ds_list_size(list);
    var array = array_create(size, 0);
    var value = 0;

    for (var i = 0; i < size; i++)
    {
        value = ds_list_find_value(list, i);
        array[i] = is_undefined(value) ? 0 : value;
    }

    ds_list_clear(list);
    return array;
}

function scr_array_to_ds_list(list, array)
{
    ds_list_clear(list);

    for (var i = 0; i < array_length(array); i++)
        ds_list_add(list, array[i]);

    return list;
}

function scr_load_bingo_data()
{
    global.recruits_list = ds_list_create();
    ds_list_add(global.recruits_list,
        // Chapter 2 (10)
        30, 31, 32, 33, 34, 35, 36, 40, 42, 44,
        // Chapter 3 (8)
        54, 55, 56, 57, 58, 59, 60, 61,
        // Chapter 4 (8)
        62, 63, 64, 65, 66, 67, 68, 69);
        // Total: 26
    global.hits = 0;
    global.prev_hits = 0;
    global.num_goals = 133;
    global.room_id = "";
    global.password = "";
    global.nickname = "";
    global.color = "";
    global.last_card_timestamp = 0;
    global.goal_progress = array_create(global.num_goals, 0);
    global.hit_counter = false;
    global.show_board = true;
    global.board_key = ord("B");
    global.chat_key = ord("T");
    global.reveal_key = ord("R");
    global.toggle_chat_key = ord("Y");
    global.board_key_gp = gp_face3;
    global.chat_key_gp = gp_shoulderl;
    global.reveal_key_gp = gp_start;
    global.toggle_chat_key_gp = gp_select;
    global.show_connections = true;
    global.show_reveals = true;
    global.show_chats = true;
    global.show_colors = true;
    global.show_goal_marks = true;
    global.show_new_cards = true;
    global.shop_items = array_create(2, 0);
    global.bananas = array_create(2, 0);
    global.eggs = array_create(4, 0);
    global.fix_us = array_create(3, 0);
    global.smorg = array_create(3, 0);
    global.berdly_encounters = array_create(2, 0);
    global.revivemints = array_create(10, 0);
    global.dojo_challenges = array_create(6, 0);
    global.wrong_warps = array_create(7, "");
    global.recruits = array_create(ds_list_size(global.recruits_list), 0);
    global.golden_sheets = array_create(3, 0);
    global.golden_items = array_create(5, 0);
    global.secret_bosses = array_create(4, 0);
    global.main_bosses = array_create(5, 0);
    global.ribbons = array_create(4, 0);
    global.b2_photos = array_create(4, 0);
    global.chapter_recruits = array_create(3, 0);
    global.armors_got = array_create(55, 0);
    global.weapons_got = array_create(55, 0);

    if (file_exists("bingo_data.json"))
    {
        var file = file_text_open_read("bingo_data.json");
        var json = json_parse(file_text_read_string(file));
        file_text_close(file);

        if (variable_struct_exists(json, "last_saved_room"))
        {
            if (variable_struct_exists(json.last_saved_room, "room_id")) global.room_id = json.last_saved_room.room_id;
            if (variable_struct_exists(json.last_saved_room, "password")) global.password = json.last_saved_room.password;
            if (variable_struct_exists(json.last_saved_room, "nickname")) global.nickname = json.last_saved_room.nickname;
            if (variable_struct_exists(json.last_saved_room, "color")) global.color = json.last_saved_room.color;
            if (variable_struct_exists(json.last_saved_room, "starred_goals")) global.starred_goals = json.last_saved_room.starred_goals;
            if (variable_struct_exists(json.last_saved_room, "last_card_timestamp")) global.last_card_timestamp = json.last_saved_room.last_card_timestamp;
        }

        if (variable_struct_exists(json, "preferences"))
        {   
            if (variable_struct_exists(json.preferences, "hit_counter")) global.hit_counter = json.preferences.hit_counter;
            if (variable_struct_exists(json.preferences, "show_chat")) global.show_chat = json.preferences.show_chat;
            if (variable_struct_exists(json.preferences, "show_board")) global.show_board = json.preferences.show_board;
        }

        if (variable_struct_exists(json, "keybinds"))
        {
            if (variable_struct_exists(json.keybinds, "board")) global.board_key = json.keybinds.board;
            if (variable_struct_exists(json.keybinds, "chat")) global.chat_key = json.keybinds.chat;
            if (variable_struct_exists(json.keybinds, "reveal")) global.reveal_key = json.keybinds.reveal;
            if (variable_struct_exists(json.keybinds, "toggle_chat")) global.toggle_chat_key = json.keybinds.toggle_chat;
            if (variable_struct_exists(json.keybinds, "board_gp")) global.board_key_gp = json.keybinds.board_gp;
            if (variable_struct_exists(json.keybinds, "chat_gp")) global.chat_key_gp = json.keybinds.chat_gp;
            if (variable_struct_exists(json.keybinds, "reveal_gp")) global.reveal_key_gp = json.keybinds.reveal_gp;
            if (variable_struct_exists(json.keybinds, "toggle_chat_gp")) global.toggle_chat_key_gp = json.keybinds.toggle_chat_gp;
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
            var list = ds_list_create();

            if (variable_struct_exists(json.progress, "general")) global.goal_progress = scr_ds_list_to_array(list, json.progress.general);
            
            if (variable_struct_exists(json.progress, "hits")) global.hits = json.progress.hits;

            if (variable_struct_exists(json.progress, "specific"))
            {
                if (variable_struct_exists(json.progress.specific, "shop_items")) global.shop_items = scr_ds_list_to_array(list, json.progress.specific.shop_items);
                if (variable_struct_exists(json.progress.specific, "bananas")) global.bananas = scr_ds_list_to_array(list, json.progress.specific.bananas);
                if (variable_struct_exists(json.progress.specific, "eggs")) global.eggs = scr_ds_list_to_array(list, json.progress.specific.eggs);
                if (variable_struct_exists(json.progress.specific, "fix_us")) global.fix_us = scr_ds_list_to_array(list, json.progress.specific.fix_us);
                if (variable_struct_exists(json.progress.specific, "smorg")) global.smorg = scr_ds_list_to_array(list, json.progress.specific.smorg);
                if (variable_struct_exists(json.progress.specific, "berdly_encounters")) global.berdly_encounters = scr_ds_list_to_array(list, json.progress.specific.berdly_encounters);
                if (variable_struct_exists(json.progress.specific, "revivemints")) global.revivemints = scr_ds_list_to_array(list, json.progress.specific.revivemints);
                if (variable_struct_exists(json.progress.specific, "dojo_challenges")) global.dojo_challenges = scr_ds_list_to_array(list, json.progress.specific.dojo_challenges);
                if (variable_struct_exists(json.progress.specific, "wrong_warps")) global.wrong_warps = scr_ds_list_to_array(list, json.progress.specific.wrong_warps);
                if (variable_struct_exists(json.progress.specific, "recruits")) global.recruits = scr_ds_list_to_array(list, json.progress.specific.recruits);
                if (variable_struct_exists(json.progress.specific, "golden_sheets")) global.golden_sheets = scr_ds_list_to_array(list, json.progress.specific.golden_sheets);
                if (variable_struct_exists(json.progress.specific, "golden_items")) global.golden_items = scr_ds_list_to_array(list, json.progress.specific.golden_items);
                if (variable_struct_exists(json.progress.specific, "secret_bosses")) global.secret_bosses = scr_ds_list_to_array(list, json.progress.specific.secret_bosses);
                if (variable_struct_exists(json.progress.specific, "main_bosses")) global.main_bosses = scr_ds_list_to_array(list, json.progress.specific.main_bosses);
                if (variable_struct_exists(json.progress.specific, "ribbons")) global.ribbons = scr_ds_list_to_array(list, json.progress.specific.ribbons);
                if (variable_struct_exists(json.progress.specific, "b2_photos")) global.b2_photos = scr_ds_list_to_array(list, json.progress.specific.b2_photos);
                if (variable_struct_exists(json.progress.specific, "chapter_recruits")) global.chapter_recruits = scr_ds_list_to_array(list, json.progress.specific.chapter_recruits);
                if (variable_struct_exists(json.progress.specific, "armors_got")) global.armors_got = scr_ds_list_to_array(list, json.progress.specific.armors_got);
                if (variable_struct_exists(json.progress.specific, "weapons_got")) global.weapons_got = scr_ds_list_to_array(list, json.progress.specific.weapons_got);
            }

            ds_list_destroy(list);
        }
    }
}

function scr_save_bingo_data()
{
    var list = ds_list_create();
    var file = file_text_open_write("bingo_data.json");
    var data = {};
    data.last_saved_room = {};
    data.preferences = {};
    data.keybinds = {};
    data.filters = {};
    data.progress = {};
    data.progress.specific = {};
    data.last_saved_room.room_id = global.room_id;
    data.last_saved_room.password = global.password;
    data.last_saved_room.nickname = global.nickname;
    data.last_saved_room.color = global.color;
    data.last_saved_room.starred_goals = global.starred_goals;
    data.last_saved_room.last_card_timestamp = global.last_card_timestamp;
    data.preferences.hit_counter = global.hit_counter;
    data.preferences.show_chat = global.show_chat;
    data.preferences.show_board = global.show_board;
    data.keybinds.board = global.board_key;
    data.keybinds.chat = global.chat_key;
    data.keybinds.reveal = global.reveal_key;
    data.keybinds.toggle_chat = global.toggle_chat_key;
    data.keybinds.board_gp = global.board_key_gp;
    data.keybinds.chat_gp = global.chat_key_gp;
    data.keybinds.reveal_gp = global.reveal_key_gp;
    data.keybinds.toggle_chat_gp = global.toggle_chat_key_gp;
    data.filters.connections = global.show_connections;
    data.filters.reveals = global.show_reveals;
    data.filters.chats = global.show_chats;
    data.filters.colors = global.show_colors;
    data.filters.goal_marks = global.show_goal_marks;
    data.filters.new_cards = global.show_new_cards;
    data.progress.general = ds_list_write(scr_array_to_ds_list(list, global.goal_progress));
    data.progress.hits = global.hits;
    data.progress.specific.shop_items = ds_list_write(scr_array_to_ds_list(list, global.shop_items));
    data.progress.specific.bananas = ds_list_write(scr_array_to_ds_list(list, global.bananas));
    data.progress.specific.eggs = ds_list_write(scr_array_to_ds_list(list, global.eggs));
    data.progress.specific.fix_us = ds_list_write(scr_array_to_ds_list(list, global.fix_us));
    data.progress.specific.smorg = ds_list_write(scr_array_to_ds_list(list, global.smorg));
    data.progress.specific.berdly_encounters = ds_list_write(scr_array_to_ds_list(list, global.berdly_encounters));
    data.progress.specific.revivemints = ds_list_write(scr_array_to_ds_list(list, global.revivemints));
    data.progress.specific.dojo_challenges = ds_list_write(scr_array_to_ds_list(list, global.dojo_challenges));
    data.progress.specific.wrong_warps = ds_list_write(scr_array_to_ds_list(list, global.wrong_warps));
    data.progress.specific.recruits = ds_list_write(scr_array_to_ds_list(list, global.recruits));
    data.progress.specific.golden_sheets = ds_list_write(scr_array_to_ds_list(list, global.golden_sheets));
    data.progress.specific.golden_items = ds_list_write(scr_array_to_ds_list(list, global.golden_items));
    data.progress.specific.secret_bosses = ds_list_write(scr_array_to_ds_list(list, global.secret_bosses));
    data.progress.specific.main_bosses = ds_list_write(scr_array_to_ds_list(list, global.main_bosses));
    data.progress.specific.ribbons = ds_list_write(scr_array_to_ds_list(list, global.ribbons));
    data.progress.specific.b2_photos = ds_list_write(scr_array_to_ds_list(list, global.b2_photos));
    data.progress.specific.chapter_recruits = ds_list_write(scr_array_to_ds_list(list, global.chapter_recruits));
    data.progress.specific.armors_got = ds_list_write(scr_array_to_ds_list(list, global.armors_got));
    data.progress.specific.weapons_got = ds_list_write(scr_array_to_ds_list(list, global.weapons_got));
    ds_list_destroy(list);
    file_text_write_string(file, json_stringify(data));
    file_text_close(file);
    ossafe_savedata_save();
}

function scr_reset_bingo_data()
{
    global.goal_progress = array_create(global.num_goals, 0);
    global.starred_goals = array_create(25, false);
    global.shop_items = array_create(array_length(global.shop_items), 0);
    global.bananas = array_create(array_length(global.bananas), 0);
    global.eggs = array_create(array_length(global.eggs), 0);
    global.fix_us = array_create(array_length(global.fix_us), 0);
    global.smorg = array_create(array_length(global.smorg), 0);
    global.berdly_encounters = array_create(array_length(global.berdly_encounters), 0);
    global.revivemints = array_create(array_length(global.revivemints), 0);
    global.dojo_challenges = array_create(array_length(global.dojo_challenges), 0);
    global.wrong_warps = array_create(array_length(global.wrong_warps), "");
    global.recruits = array_create(array_length(global.recruits), 0);
    global.golden_sheets = array_create(array_length(global.golden_sheets), 0);
    global.golden_items = array_create(array_length(global.golden_items), 0);
    global.secret_bosses = array_create(array_length(global.secret_bosses), 0);
    global.main_bosses = array_create(array_length(global.main_bosses), 0);
    global.ribbons = array_create(array_length(global.ribbons), 0);
    global.b2_photos = array_create(array_length(global.b2_photos), 0);
    global.chapter_recruits = array_create(array_length(global.chapter_recruits), 0);
    global.armors_got = array_create(array_length(global.armors_got), 0);
    global.weapons_got = array_create(array_length(global.weapons_got), 0);
    global.hits = 0;
    scr_save_bingo_data();
}

function scr_goal_slot_from_name(name)
{
    name = string_lower(string_trim(name));

    for (var i = 0; i < array_length(global.goal_slot); i++)
    {
        if (string_lower(global.goal_name[i]) == name)
            return string_digits(global.goal_slot[i]);
    }

    return 0;
}

function scr_goal_requirements(slot)
{
    if (slot < 0 || slot >= global.num_goals)
        return false;

    switch (slot)
    {
        case 0: return global.goal_progress[slot] >= 2000;

        case 2:
        case 16:
        case 80:
            return global.goal_progress[slot] >= 10;

        case 3:
        case 72:
            return global.goal_progress[slot] >= 5;

        case 10: return global.goal_progress[slot] >= 25;
        case 22: return global.goal_progress[slot] >= 3000;
        case 30: return global.goal_progress[slot] >= 15;
        case 31: return global.goal_progress[slot] >= 20;
        case 42: return global.goal_progress[slot] >= 3;
        case 78: return global.goal_progress[slot] >= 2;
        default: return global.goal_progress[slot] >= 1;
    }
}

function scr_internal_name_from_slot(slot)
{
    switch (slot)
    {
        case 0:   return "$2000";
        case 1:   return "get an egg (original source)";
        case 2:   return "spare/pacify 10 enemies";
        case 3:   return "kill 5 enemies";
        case 4:   return "bed inspector";
        case 5:   return "complete jevil";
        case 6:   return "get the freeze ring";
        case 7:   return "die";
        case 8:   return "buy an item from seam and rouxls";
        case 9:   return "complete the hacker side quest";
        case 10:  return "spare/pacify 25 enemies";
        case 11:  return "buy the royal pin (ch2 mansion shop)";
        case 12:  return "defeat king";
        case 13:  return "finish chapter 1";
        case 14:  return "defeat giga queen";
        case 15:  return "defeat queen";
        case 16:  return "kill 10 enemies";
        case 17:  return "complete the giasfelfebrehber puzzle";
        case 18:  return "collect 2 bananas";
        case 19:  return "get the spin cake";
        case 20:  return "fuse an item";
        case 21:  return "get 2 eggs";
        case 22:  return "$3000";
        case 23:  return "use susie's ultimate heal";
        case 24:  return "do 'fix us' in all possible chapters";
        case 25:  return "talk to starwalker";
        case 26:  return "get the dice brace";
        case 27:  return "complete all smorgasbords";
        case 28:  return "enter the dark world without using the bed";
        case 29:  return "get the thorn ring (original source)";
        case 30:  return "spare/pacify 15 enemies";
        case 31:  return "kill 20 enemies";
        case 32:  return "complete 3 challenges in party dojo";
        case 33:  return "complete spamton neo (basement)";
        case 34:  return "complete both berdly encounters";
        case 35:  return "buy something from spamton's shop";
        case 36:  return "get 3 revivemints";
        case 37:  return "eat moss";
        case 38:  return "complete the sweet cap'n cakes battle";
        case 39:  return "fill up your inventory";
        case 40:  return "open the balloon chest (city heights)";
        case 41:  return "abort snowgrave after getting the freeze ring";
        case 42:  return "hit 3 pipis";
        case 43:  return "complete spamton neo (snowgrave)";
        case 44:  return "complete the spamton encounter (normal)";
        case 45:  return "complete the spelling bee cutscene (mansion)";
        case 46:  return "get captured in chapter 2";
        case 47:  return "get a lancer cookie";
        case 48:  return "build the flb duck (pink)";
        case 49:  return "see obj_weirdroute_manipulator";
        case 50:  return "recruit mauswheel";
        case 51:  return "lose tasque manager";
        case 52:  return "recruit werewerewire";
        case 53:  return "lose werewerewire";
        case 54:  return "watch the lesbian cutscene";
        case 55:  return "beat the rouxls fight (ch2/ch3)";
        case 56:  return "get revivedust";
        case 57:  return "talk to the green swatchling";
        case 58:  return "crash with bagel overflow";
        case 59:  return "trigger milk on the 2nd k.round fight";
        case 60:  return "spare clover without using the manual (ch1)";
        case 61:  return "lose mauswheel";
        case 62:  return "watch the legend";
        case 63:  return "complete the dummy tutorial";
        case 64:  return "hug ralsei";
        case 65:  return "talk to lancer in the epilogue";
        case 66:  return "spare ponman";
        case 67:  return "beat triple rabbick";
        case 68:  return "build the cutest machine";
        case 69:  return "get a glowshard";
        case 70:  return "ww into 7 unique rooms";
        case 71:  return "recruit 3 different enemies";
        case 72:  return "heal in battles 5 times";
        case 73:  return "hit a baby car";
        case 74:  return "full berdly spare";
        case 75:  return "equip white ribbon (ch1/ch3)";
        case 76:  return "pot balance";
        case 77:  return "donate d$1";
        case 78:  return "get both chests on 2 maus 1 maus";
        case 79:  return "use dual heal";
        case 80:  return "pacify 10 enemies";
        case 81:  return "get ms.pipis";
        case 82:  return "speak to sans";
        case 83:  return "place the egg in hometown";
        case 84:  return "visit rudy";
        case 85:  return "z rank board 1 or 2";
        case 86:  return "get to the tropic of love";
        case 87:  return "bomberman key (board 1)";
        case 88:  return "beat fake gerson";
        case 89:  return "get pipis";
        case 90:  return "recruit miss mizzle";
        case 91:  return "lose miss mizzle";
        case 92:  return "recruit watercooler";
        case 93:  return "lose watercooler";
        case 94:  return "beat titan";
        case 95:  return "beat tenna";
        case 96:  return "beat the knight";
        case 97:  return "beat gerson";
        case 98:  return "play megalovania on the big piano";
        case 99:  return "reach the knight at the start of ch4";
        case 100: return "beat nightmare";
        case 101: return "beat mike";
        case 102: return "find the 3 golden sheets";
        case 103: return "have a tea party with gerson";
        case 104: return "enter ralsei's room";
        case 105: return "get princessribbon";
        case 106: return "get 2 gold items";
        case 107: return "spend 1225 points in the gamble machine";
        case 108: return "get goldwidow";
        case 109: return "get bittertear";
        case 110: return "defeat 2 secret bosses";
        case 111: return "defeat 2 main bosses";
        case 112: return "get ice key";
        case 113: return "get shelter key";
        case 114: return "get the 4 ribbons";
        case 115: return "kill a titan spawn";
        case 116: return "show compassion to ralsei";
        case 117: return "get 4 photos (board 2)";
        case 118: return "get quiz key (board 1)";
        case 119: return "b or better rank susiezilla";
        case 120: return "find the among us reference";
        case 121: return "get a shadow crystal";
        case 122: return "get a dog dollar";
        case 123: return "get annoying dog on rouxls";
        case 124: return "recruit shuttah";
        case 125: return "lose shuttah";
        case 126: return "lose rabbick (ch3)";
        case 127: return "go to the diner with susie";
        case 128: return "recruit an enemy in each chapter";
        case 129: return "lanino/elnina rematch";
        case 130: return "obtain 5 armors";
        case 131: return "obtain 5 weapons";
        case 132: return "tell jackenstein he's cute";
        default:  return "none";
    }
}

function scr_add_goal_array(array_name, index, slot)
{
    var array = variable_global_get(array_name);
    var total = 0;
    var threshold = 0;
    array[index]++;
    variable_global_set(array_name, array);
    scr_save_bingo_data();

    for (var i = 0; i < array_length(array); i++)
    {
        if (array[i] >= 1)
            total++;
    }

    switch (slot)
    {
        case 21:
        case 106:
        case 110:
        case 111:
            threshold = 2;
            break;

        case 32:
        case 36:
        case 71:
            threshold = 3;
            break;

        case 130:
        case 131:
            threshold = 5;
            break;

        default:
            threshold = array_length(array);
            break;
    }

    if (total >= threshold)
        scr_add_goal_progress(slot, 1);
}

function scr_add_goal_money(amount)
{
    scr_add_goal_progress(0, amount);
    scr_add_goal_progress(22, amount);
}

function scr_add_goal_progress(slot, amount)
{
    if (global.ws_client == -1)
        exit;

    global.goal_progress[slot] += amount;

    if (scr_goal_requirements(slot))
    {
        var board_slot = scr_goal_slot_from_name(scr_internal_name_from_slot(slot));

        if (board_slot > 0 && string_pos(global.color, global.goal_colors[board_slot - 1]) == 0)
        {
            // Prevent goals from triggering multiple times in quick succession (the colors will be updated properly when the board request comes through anyway)
            if (global.goal_colors[board_slot - 1] == "blank")
            {
                update_colors = false;
                global.goal_colors[board_slot - 1] = global.color;
                obj_bingo_controller.alarm[0] = 3 * room_speed;
            }
            // Prevent your color from showing up when you mark a taken goal with Lockout enabled
            else if (global.room_lockout == "Non-Lockout")
            {
                update_colors = false;
                global.goal_colors[board_slot - 1] += " " + global.color;
                obj_bingo_controller.alarm[0] = 3 * room_speed;
            }

            ossafe_http_post("https://bingosync.com/api/select", "{ \"room\": \"" + scr_escape_string(global.room_id) + "\", \"color\": \"" + global.color + "\", \"slot\": \"" + board_slot + "\", \"remove_color\": false }");
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
    }
    else if (room != room_dw_mansion_b_west_2f)
#elsif CHAPTER_3
    if (instance_exists(obj_knight_enemy))
    {
        switch (global.knight_hits_type)
        {
            case 0:
                if (instance_exists(obj_sword_tunnel_manager) && obj_sword_tunnel_manager.con == 0)
                    global.knight_hits_type = 1; // Got hit to a sword in the corridor part of the attack

                break;

            case 1: // Already got hit to the sword corridor, don't count again
                exit;

            // In the final attack,
            // there's multiple bullets created in the exact same spots, so when you get hit it counts more than once.
            // The idea here is when you get hit once, wait a frame to see the difference in the hit count
            // and if it's greater than 1, only count 1.
            case 2:
                if (global.knight_frame_delay == -1)
                {
                    global.prev_hits = global.hits;
                    global.knight_frame_delay = call_later(1, 1, function()
                    {
                        if ((global.hits - global.prev_hits) > 1)
                            global.hits = global.prev_hits + 1;

                        global.knight_frame_delay = -1;
                    });
                    break;
                }

                exit;
        }
    }
#endif
    global.hits++;
    scr_save_bingo_data();
}