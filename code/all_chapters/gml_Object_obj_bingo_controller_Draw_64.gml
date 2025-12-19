/// IMPORT

scr_get_temp_draw();
var grid_size = 5;
var square_size = 58;
var spacing = 2;
var base_x = 340;
var base_y = 1;
var new_lines = 0;
var surface_width = surface_get_width(application_surface);
var surface_height = surface_get_height(application_surface);
draw_set_alpha(1);
draw_set_font(fnt_main);

if (global.show_board && board_connected)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    var len = (grid_size * square_size) + ((grid_size - 1) * spacing);

    if (!board_revealed)
    {
        draw_set_color(c_navy);
        ossafe_fill_rectangle(base_x, base_y, base_x + len, base_y + len);
        draw_set_color(c_white);
        var text_x = ((2 * base_x) + len) / 2;
        var text_y = ((2 * base_y) + len) / 2;
        draw_text_outline(text_x, text_y, "The card is hidden!");
        var kb_key = scr_input_name(global.reveal_key);
        var gp_key = scr_input_name_gp(global.reveal_key_gp);

        if (is_string(gp_key))
        {
            draw_text_outline(text_x, text_y + 15, "Press " + kb_key + " or " + gp_key + " to reveal it.");
        }
        else
        {
            var before_text = "Press " + kb_key + " or";
            var after_text = "to reveal it.";
            var total_w = string_width(before_text) + sprite_get_width(gp_key) + string_width(after_text);
            draw_text_outline(text_x, text_y + 15, "Press " + kb_key + " or      to reveal it.");
            draw_sprite(gp_key, 0, round((text_x - (total_w / 2)) + string_width(before_text)), round(text_y + 8));
        }
    }
    else
    {
        var idx = 0;
        var i = 0;
        var j = 0;
        var c = 0;
        var x1 = 0;
        var y1 = 0;
        var x2 = 0;
        var y2 = 0;
        var colors_array = [];
        var num_colors = 0;
        var section_width = 0;
        var shown_str = "";
        draw_set_color(c_black);
        ossafe_fill_rectangle(base_x - 1, base_y - 1, base_x + len + 1, base_y + len + 1);

        for (i = 0; i < grid_size; i++)
        {
            for (j = 0; j < grid_size; j++)
            {
                x1 = base_x + (j * (square_size + spacing));
                y1 = base_y + (i * (square_size + spacing));
                x2 = x1 + square_size;
                y2 = y1 + square_size;
                colors_array = string_split(global.goal_colors[idx], " ", true);

                if (!global.show_other_colors)
                    colors_array = (string_pos(global.color, global.goal_colors[idx]) > 0) ? [global.color] : ["blank"];

                num_colors = array_length(colors_array);
                section_width = square_size / num_colors;

                for (c = 0; c < num_colors; c++)
                {
                    draw_set_color(scr_color_from_name(colors_array[c]));
                    ossafe_fill_rectangle(x1 + (c * section_width), y1, x1 + ((c + 1) * section_width), y2);
                }

                if (global.starring_goals && point_in_rectangle(obj_time.mousex, obj_time.mousey, x1, y1, x2, y2) && scr_check_mouse_pressed(mb_left, global.input_g[4]))
                {
                    global.starred_goals[idx] = !global.starred_goals[idx];
                    scr_save_bingo_data();
                }

                if (global.starred_goals[idx])
                    draw_sprite(spr_goal_star, 0, x1, y1);

                draw_set_color(c_white);

                switch (string_lower(global.goal_name[idx]))
                {
                    case "see obj_weirdroute_manipulator":
                        shown_str = string_insert("\n", global.goal_name[idx], 20);
                        break;

                    default:
                        shown_str = global.goal_name[idx];
                        break;
                }

                draw_text_ext_transformed((x1 + x2) / 2, (y1 + y2) / 2, shown_str, 15, (x2 - x1) + 50, 0.5, 0.5, 0);
                idx++;
            }
        }
    }
}

if (global.room_seed != -1)
{
    draw_set_color(c_yellow);
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    var text_x = (base_x + ((square_size + spacing) * grid_size)) - 1;
    var text_y = ((base_y + ((square_size + spacing) * grid_size)) - (2 * spacing)) + 2;
    var text_y_offset = (instance_exists(obj_darkcontroller) && global.interact == 5) ? obj_darkcontroller.tp : 0;
    var final_y = (global.show_board && board_connected) ? text_y : text_y_offset;
    draw_text_outline(text_x, final_y, "Seed: " + (board_revealed ? string(global.room_seed) : "Hidden") + " / " + global.room_lockout);

    var kb_key = scr_input_name(global.board_key);
    var gp_key = scr_input_name_gp(global.board_key_gp);
    var toggle_text = global.show_board ? "Hide board" : "Show board";
    if (is_string(gp_key))
    {
        draw_text_outline(text_x, final_y + 15, kb_key + ", " + gp_key + ": " + toggle_text);
    }
    else
    {
        draw_text_outline(text_x, final_y + 15, kb_key + ",      : " + toggle_text);
        draw_sprite_ext(gp_key, 0, round(text_x - string_width("     : " + toggle_text)), round(final_y + 17), 1, 1, 0, c_yellow, 1);
    }

    kb_key = scr_input_name(global.toggle_chat_key);
    gp_key = scr_input_name_gp(global.toggle_chat_key_gp);
    toggle_text = global.show_chat ? "Hide chat" : "Show chat";
    if (is_string(gp_key))
    {
        draw_text_outline(text_x, final_y + 30, kb_key + ", " + gp_key + ": " + toggle_text);
    }
    else
    {
        draw_text_outline(text_x, final_y + 30, kb_key + ",      : " + toggle_text);
        draw_sprite_ext(gp_key, 0, round(text_x - string_width("     : " + toggle_text)), round(final_y + 32), 1, 1, 0, c_yellow, 1);
    }

    kb_key = scr_input_name(global.chat_key);
    gp_key = scr_input_name_gp(global.chat_key_gp);
    if (is_string(gp_key))
    {
        draw_text_outline(text_x, final_y + 45, kb_key + ", " + gp_key + ": Open chatbox");
    }
    else
    {
        draw_text_outline(text_x, final_y + 45, kb_key + ",      : Open chatbox");
        draw_sprite_ext(gp_key, 0, round(text_x - string_width("     : Open chatbox")), round(final_y + 47), 1, 1, 0, c_yellow, 1);
    }

    kb_key = scr_input_name(global.color_hide_key);
    gp_key = scr_input_name_gp(global.color_hide_key_gp);
    toggle_text = global.show_other_colors ? "Hide other colors" : "Show other colors";
    if (is_string(gp_key))
    {
        draw_text_outline(text_x, final_y + 60, kb_key + ", " + gp_key + ": " + toggle_text);
    }
    else
    {
        draw_text_outline(text_x, final_y + 60, kb_key + ",      : " + toggle_text);
        draw_sprite_ext(gp_key, 0, round(text_x - string_width("     : " + toggle_text)), round(final_y + 62), 1, 1, 0, c_yellow, 1);
    }

    if (global.starring_goals)
    {
        draw_text_outline(text_x, text_y + 85, "* Click or press      on goals to star them. *");
        draw_text_outline(text_x, text_y + 100, "* ESC,      : Cancel *");
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[4]), 0, round(text_x - string_width("     on goals to star them. *")), round(text_y + 87), 1, 1, 0, c_yellow, 1);
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[5]), 0, round(text_x - string_width("     : Cancel *")), round(text_y + 102), 1, 1, 0, c_yellow, 1);
    }
}

if (global.chat_typing)
{
    if (!global.is_console)
    {
        if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
            keyboard_string += clipboard_get_text();

        if (string_length(keyboard_string) > 100)
            keyboard_string = string_copy(keyboard_string, 1, 100);

        var shown_str = keyboard_string;
        new_lines = 0;

        while (string_width_ext(shown_str, 15, surface_width) >= surface_width)
        {
            new_lines++;
            shown_str = string_insert("\n", shown_str, 50 * new_lines);
        }

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_ltgray);
        draw_text_outline(1, surface_height - 48, "Typing in chat. Press ESC or      to cancel. Commands: /color, /star, /autoconnect.");
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[5]), 0, round(0.5 + string_width("Typing in chat. Press ESC or ")), round(surface_height - 46), 1, 1, 0, c_ltgray, 1);
        draw_set_color(c_dkgray);
        ossafe_fill_rectangle(0, surface_height - 30, surface_width, surface_height);
        draw_set_color(c_white);
        draw_text_outline_ext(1, surface_height - 32, ((global.time % 30) < 15) ? (shown_str + "_") : shown_str, 15, surface_width);
    }

    if (keyboard_check_pressed(vk_enter) || mystring != "")
    {
        var str;

        if (global.is_console)
            str = scr_escape_string(string_trim(mystring));
        else
            str = scr_escape_string(string_trim(keyboard_string));

        if (string_length(str) > 0)
        {
            var str_lower = string_lower(str);

            if (string_pos("/color", str_lower) == 1 || string_pos("/colour", str_lower) == 1)
            {
                var split_string = string_split(str_lower, " ");
                var chosen_color = "blank";

                if (array_length(split_string) > 1)
                    chosen_color = split_string[1];

                if (chosen_color == "blank" || scr_color_from_name(chosen_color) == c_white)
                {
                    scr_chat_message(c_red, "Invalid color. Use orange, red, blue, green, purple, navy, teal, brown, pink or yellow.");
                }
                else
                {
                    global.color = chosen_color;
                    scr_save_bingo_data();
                    ossafe_http_post("https://bingosync.com/api/color", "{ \"room\": \"" + global.room_id + "\", \"color\": \"" + global.color + "\" }");
                }
            }
            else if (string_pos("/star", str_lower) == 1)
            {
                if (!global.show_board || !board_connected || !board_revealed)
                {
                    scr_chat_message(c_red, "You can't star goals while the board is hidden.");
                }
                else
                {
                    global.starring_goals = true;
                    scr_show_mouse_at(window_get_width() / 2, window_get_height() / 2);
                }
            }
            else if (string_pos("/autoconnect", str_lower) == 1)
            {
                if (!global.autoconnect)
                {
                    global.autoconnect = true;
                    scr_chat_message(c_yellow, "You will now automatically connect to this room when starting the game.");
                }
                else
                {
                    global.autoconnect = false;
                    scr_chat_message(c_yellow, "You will no longer automatically connect to this room when starting the game.");
                }

                scr_save_bingo_data();
            }
            else
            {
                ossafe_http_post("https://bingosync.com/api/chat", "{ \"room\": \"" + global.room_id + "\", \"text\": \"" + str + "\" }");
            }
        }

        global.chat_typing = false;
        keyboard_clear(vk_enter);
        keyboard_string = "";
        mystring = "";
    }
}

scr_set_temp_draw();