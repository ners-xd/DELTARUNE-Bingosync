/// IMPORT

draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_yellow);
#if CHAPTER_1 || CHAPTER_2
draw_text(0, 0, "Bingosync Mod " + scr_get_mod_version() + " (Chapter " + string(global.chapter) + ")");
#else
draw_text(0, 0, "Bingosync Mod v" + scr_get_mod_version() + " (Chapter " + string(global.chapter) + ")");
#endif
var base_x = 320;
var base_y = 70;
var spacing = 20;
var kb_key;
var gp_key;
var text_connect = "Connect to room";
var text_room_id = "Room ID: " + ((global.room_id != "" || sel == 1) ? global.room_id : "[Empty. Select to be able to type]");
var text_password = "Password: " + ((global.password != "" || sel == 2) ? censor_password() : "[Empty. Select to be able to type]");
var text_nickname = "Nickname: " + ((global.nickname != "" || sel == 3) ? global.nickname : "[Empty. Select to be able to type]");
var text_color = "Color: " + ((global.color != "" || sel == 4) ? global.color : "[Empty. Select to be able to type]");
var text_reset = (sel == 5) ? "Reset progress? Select again to confirm!" : "Reset progress";
var text_board;

if (sel == 6)
{
    text_board = "Board toggle keybind: Listening...";
}
else
{
    kb_key = scr_input_name(global.board_key);
    gp_key = scr_input_name_gp(global.board_key_gp);

    if (is_string(gp_key))
    {
        text_board = "Board toggle keybind: " + kb_key + ", " + gp_key;
    }
    else
    {
        text_board = "Board toggle keybind: " + kb_key + ", ";
        draw_sprite_ext(gp_key, 0, round(base_x + (string_width(text_board) / 2)), round((base_y + (6 * spacing)) - 6), 1, 1, 0, (pos == 6) ? c_yellow : c_white, 1);
    }
}

var text_chat;

if (sel == 7)
{
    text_chat = "Chat keybind: Listening...";
}
else
{
    kb_key = scr_input_name(global.chat_key);
    gp_key = scr_input_name_gp(global.chat_key_gp);

    if (is_string(gp_key))
    {
        text_chat = "Chat keybind: " + kb_key + ", " + gp_key;
    }
    else
    {
        text_chat = "Chat keybind: " + kb_key + ", ";
        draw_sprite_ext(gp_key, 0, round(base_x + (string_width(text_chat) / 2)), round((base_y + (7 * spacing)) - 6), 1, 1, 0, (pos == 7) ? c_yellow : c_white, 1);
    }
}

var text_reveal;

if (sel == 8)
{
    text_reveal = "Board reveal keybind: Listening...";
}
else
{
    kb_key = scr_input_name(global.reveal_key);
    gp_key = scr_input_name_gp(global.reveal_key_gp);

    if (is_string(gp_key))
    {
        text_reveal = "Board reveal keybind: " + kb_key + ", " + gp_key;
    }
    else
    {
        text_reveal = "Board reveal keybind: " + kb_key + ", ";
        draw_sprite_ext(gp_key, 0, round(base_x + (string_width(text_reveal) / 2)), round((base_y + (8 * spacing)) - 6), 1, 1, 0, (pos == 8) ? c_yellow : c_white, 1);
    }
}

var text_toggle_chat;

if (sel == 9)
{
    text_toggle_chat = "Chat toggle keybind: Listening...";
}
else
{
    kb_key = scr_input_name(global.toggle_chat_key);
    gp_key = scr_input_name_gp(global.toggle_chat_key_gp);

    if (is_string(gp_key))
    {
        text_toggle_chat = "Chat toggle keybind: " + kb_key + ", " + gp_key;
    }
    else
    {
        text_toggle_chat = "Chat toggle keybind: " + kb_key + ", ";
        draw_sprite_ext(gp_key, 0, round(base_x + (string_width(text_toggle_chat) / 2)), round((base_y + (9 * spacing)) - 6), 1, 1, 0, (pos == 9) ? c_yellow : c_white, 1);
    }
}

var text_connections = "Show connection/disconnection messages: " + (global.show_connections ? "Yes" : "No");
var text_reveals = "Show board reveal messages: " + (global.show_reveals ? "Yes" : "No");
var text_chats = "Show chat messages from players: " + (global.show_chats ? "Yes" : "No");
var text_colors = "Show color change messages: " + (global.show_colors ? "Yes" : "No");
var text_goal_marks = "Show goal mark/clear messages: " + (global.show_goal_marks ? "Yes" : "No");
var text_new_cards = "Show new board messages: " + (global.show_new_cards ? "Yes" : "No");
var text_hit_counter = "Show hit counter: " + (global.hit_counter ? "Yes" : "No");
var selected_text;

switch (pos)
{
    case 0:
        selected_text = text_connect;
        break;

    case 1:
        selected_text = text_room_id;
        break;

    case 2:
        selected_text = text_password;
        break;

    case 3:
        selected_text = text_nickname;
        break;

    case 4:
        selected_text = text_color;
        break;

    case 5:
        selected_text = text_reset;
        break;

    case 6:
        selected_text = text_board;
        break;

    case 7:
        selected_text = text_chat;
        break;

    case 8:
        selected_text = text_reveal;
        break;

    case 9:
        selected_text = text_toggle_chat;
        break;

    case 10:
        selected_text = text_connections;
        break;

    case 11:
        selected_text = text_reveals;
        break;

    case 12:
        selected_text = text_chats;
        break;

    case 13:
        selected_text = text_colors;
        break;

    case 14:
        selected_text = text_goal_marks;
        break;

    case 15:
        selected_text = text_new_cards;
        break;

    case 16:
        selected_text = text_hit_counter;
        break;
}

var text_width = string_width(selected_text);
draw_sprite(spr_heart, 0, base_x - (text_width / 2) - 20, (base_y - (spacing / 3)) + (pos * spacing));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color((pos == 0) ? c_yellow : c_white);
draw_text(base_x, base_y, text_connect);
draw_set_color((pos == 1) ? c_yellow : c_white);
draw_text(base_x, base_y + spacing, text_room_id);
draw_set_color((pos == 2) ? c_yellow : c_white);
draw_text(base_x, base_y + (2 * spacing), text_password);
draw_set_color((pos == 3) ? c_yellow : c_white);
draw_text(base_x, base_y + (3 * spacing), text_nickname);
draw_set_color((pos == 4) ? c_yellow : c_white);
draw_text(base_x, base_y + (4 * spacing), text_color);
draw_set_color((pos == 5) ? c_yellow : c_white);
draw_text(base_x, base_y + (5 * spacing), text_reset);
draw_set_color((pos == 6) ? c_yellow : c_white);
draw_text(base_x, base_y + (6 * spacing), text_board);
draw_set_color((pos == 7) ? c_yellow : c_white);
draw_text(base_x, base_y + (7 * spacing), text_chat);
draw_set_color((pos == 8) ? c_yellow : c_white);
draw_text(base_x, base_y + (8 * spacing), text_reveal);
draw_set_color((pos == 9) ? c_yellow : c_white);
draw_text(base_x, base_y + (9 * spacing), text_toggle_chat);
draw_set_color((pos == 10) ? c_yellow : c_white);
draw_text(base_x, base_y + (10 * spacing), text_connections);
draw_set_color((pos == 11) ? c_yellow : c_white);
draw_text(base_x, base_y + (11 * spacing), text_reveals);
draw_set_color((pos == 12) ? c_yellow : c_white);
draw_text(base_x, base_y + (12 * spacing), text_chats);
draw_set_color((pos == 13) ? c_yellow : c_white);
draw_text(base_x, base_y + (13 * spacing), text_colors);
draw_set_color((pos == 14) ? c_yellow : c_white);
draw_text(base_x, base_y + (14 * spacing), text_goal_marks);
draw_set_color((pos == 15) ? c_yellow : c_white);
draw_text(base_x, base_y + (15 * spacing), text_new_cards);
draw_set_color((pos == 16) ? c_yellow : c_white);
draw_text(base_x, base_y + (16 * spacing), text_hit_counter);
draw_set_color(status_color);
draw_text_ext(320, base_y + ((max_pos + 2) * spacing), status_text, 15, 350);