/// IMPORT

var temp_halign = draw_get_halign();
var temp_valign = draw_get_valign();
var temp_alpha = draw_get_alpha();
var grid_size = 5;
var square_size = 58;
var spacing = 2;
var base_x = 340;
var base_y = 1;
var new_lines = 0;
var surface_width = surface_get_width(application_surface);
var surface_height = surface_get_height(application_surface);
draw_set_alpha(1);

if (global.hit_counter)
{
    draw_set_font(fnt_mainbig);
    draw_set_color(c_yellow);
    draw_text_outline(5, global.chat_typing ? (surface_height - 80) : (surface_height - 30), "Hits: " + string(global.hits), c_black);
}

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
        var colors_array = 0;
        var num_colors = 0;
        var section_width = 0;
        var shown_str = "";
        var mousex = window_mouse_get_x();
        var mousey = window_mouse_get_y();
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
                colors_array = string_split(global.goal_colors[idx], " ");
                num_colors = array_length(colors_array);
                section_width = square_size / num_colors;

                for (c = 0; c < num_colors; c++)
                {
                    draw_set_color(scr_color_from_name(colors_array[c]));
                    ossafe_fill_rectangle(x1 + (c * section_width), y1, x1 + ((c + 1) * section_width), y2);
                }

                if (global.starring_goals && mousex >= x1 && mousex <= x2 && mousey >= y1 && mousey <= y2 && scr_check_mouse_pressed(1, global.input_g[4]))
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

                draw_text_ext_transformed((x1 + x2) / 2, (y1 + y2) / 2, shown_str, 14, (x2 - x1) + 15, 0.5, 0.5, 0);
                idx++;
            }
        }

        if (global.starring_goals)
        {
            if (instance_exists(obj_gamecontroller) && obj_gamecontroller.gamepad_active)
            {
                mousex += (gamepad_axis_value(obj_gamecontroller.gamepad_id, gp_axislh) * 20);
                mousey += (gamepad_axis_value(obj_gamecontroller.gamepad_id, gp_axislv) * 20);
            }

            window_mouse_set(mousex, mousey);
            draw_sprite_ext(spr_maus_cursor, 0, mousex, mousey, 0.5, 0.5, 0, c_white, 1);
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

    if (is_string(gp_key))
    {
        draw_text_outline(text_x, final_y + 15, kb_key + ", " + gp_key + ": Toggle board");
    }
    else
    {
        draw_text_outline(text_x, final_y + 15, kb_key + ",      : Toggle board");
        draw_sprite_ext(gp_key, 0, round(text_x - string_width("     : Toggle board")), round(final_y + 17), 1, 1, 0, c_yellow, 1);
    }

    kb_key = scr_input_name(global.toggle_chat_key);
    gp_key = scr_input_name_gp(global.toggle_chat_key_gp);

    if (is_string(gp_key))
    {
        draw_text_outline(text_x, final_y + 30, kb_key + ", " + gp_key + ": Toggle chat");
    }
    else
    {
        draw_text_outline(text_x, final_y + 30, kb_key + ",      : Toggle chat");
        draw_sprite_ext(gp_key, 0, round(text_x - string_width("     : Toggle chat")), round(final_y + 32), 1, 1, 0, c_yellow, 1);
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

    if (global.starring_goals)
    {
        draw_text_outline(text_x, text_y + 64, "* Click or press      on goals to star them. *");
        draw_text_outline(text_x, text_y + 79, "* ESC,      : Cancel *");
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[4]), 0, round(text_x - string_width("     on goals to star them. *")), round(text_y + 66), 1, 1, 0, c_yellow, 1);
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[5]), 0, round(text_x - string_width("     : Cancel *")), round(text_y + 81), 1, 1, 0, c_yellow, 1);
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
        draw_text_outline(1, surface_height - 48, "Typing in chat. Press ESC or      to cancel. Commands: /color, /star.");
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[5]), 0, round(0.5 + string_width("Typing in chat. Press ESC or ")), round(surface_height - 46), 1, 1, 0, c_ltgray, 1);
        draw_set_color(c_dkgray);
        ossafe_fill_rectangle(0, surface_height - 30, surface_width, surface_height);
        draw_set_color(c_white);
        draw_text_outline_ext(1, surface_height - 32, shown_str, 15, surface_width);
    }

    if (keyboard_check_pressed(vk_enter) || mystring != "")
    {
        var str;

        if (global.is_console)
            str = scr_escape_string(mystring);
        else
            str = scr_escape_string(keyboard_string);

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
                    ossafe_http_post("https://bingosync.com/api/color", "{ \"room\": \"" + scr_escape_string(global.room_id) + "\", \"color\": \"" + global.color + "\" }");
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
                    window_mouse_set(surface_width / 2, surface_height / 2);
                }
            }
            else
            {
                ossafe_http_post("https://bingosync.com/api/chat", "{ \"room\": \"" + scr_escape_string(global.room_id) + "\", \"text\": \"" + str + "\" }");
            }
        }

        global.chat_typing = false;
        keyboard_clear(vk_enter);
        keyboard_string = "";
        mystring = "";
    }
}

draw_set_halign(temp_halign);
draw_set_valign(temp_valign);
draw_set_alpha(temp_alpha);