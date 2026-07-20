/// IMPORT

if (!board_done || !room_settings_done || !feed_done || !room_base_done)
    exit;

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

if (global.show_board)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    var len = (grid_size * square_size) + ((grid_size - 1) * spacing);

    if (!board_revealed)
    {
        draw_set_color(c_navy);
        ossafe_fill_rectangle(base_x - 1, base_y - 1, base_x + len + 1, base_y + len + 1);
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

                if (global.show_other_colors)
                    colors_array = string_split(global.goal_colors[idx], " ", true);
                else
                    colors_array = scr_is_goal_marked(idx) ? [global.color] : ["blank"];

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

                var shown_str = global.goal_name[idx];
                var goal_name_lower = string_lower(global.goal_name[idx]);
                var slot = ds_map_find_value(global.goal_indexes, goal_name_lower);
                var var_slot = ds_map_find_value(global.goal_vars_indexes, goal_name_lower);

                if (!is_undefined(var_slot) && global.goal_custom_vars[var_slot].size > 1)
                {
                    var arr_len = array_length(variable_global_get(global.goal_custom_vars[var_slot].name));
                    var filled_amount = 0;

                    for (c = 0; c < arr_len; c++)
                    {
                        if (array_get(variable_global_get(global.goal_custom_vars[var_slot].name), c) != "")
                            filled_amount++;
                    }

                    shown_str += (" [" + string(min(filled_amount, global.goal_custom_vars[var_slot].size)) + "/" + string(global.goal_custom_vars[var_slot].size) + "]");
                }
                else if (!is_undefined(slot) && global.goal_list[slot].max_progress > 1)
                {
                    shown_str += (" [" + string(min(global.goal_progress[slot], global.goal_list[slot].max_progress)) + "/" + string(global.goal_list[slot].max_progress) + "]");
                }

                draw_set_color(c_white);
                draw_text_outline_ext_transformed(((x1 + x2) / 2) + 1.25, ((y1 + y2) / 2) + 1.25, scr_is_goal_visible(idx) ? shown_str : "???", 15, (x2 - x1) + 50, 0.5, 0.5, 0);
                idx++;
            }
        }
    }
}

if (global.room_seed != -1)
{
    var text_x = (base_x + ((square_size + spacing) * grid_size)) - 1;
    var text_y = ((base_y + ((square_size + spacing) * grid_size)) - (2 * spacing)) + 2;
    var text_y_offset = 0;

    if (instance_exists(obj_darkcontroller) && obj_darkcontroller.charcon > 0 && variable_global_exists("menuno") && global.menuno > -1)
    {
        text_y_offset = obj_darkcontroller.tp;

    #if CHAPTER_5
        if (global.flag[1312] > 0)
            text_y_offset += 30;
    #endif
    }

    var final_y = global.show_board ? text_y : text_y_offset;
    draw_set_color(c_yellow);
    draw_set_valign(fa_top);

    if (global.show_board)
    {
        draw_set_halign(fa_left);
        draw_text_outline(base_x, final_y, current_board_time);
    }

    draw_set_halign(fa_right);
    draw_text_outline(text_x, final_y, (fixed_board ? "Fixed Board / " : ("Seed: " + (board_revealed ? string(global.room_seed) : "Hidden") + " / ")) + global.room_lockout);
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

#if CHAPTER_1
    if (global.egg_attempts > 0 && (room == room_forest_starwalker || room == room_forest_area5 || room == room_man))
    {
        if (room != room_man)
#elsif CHAPTER_2
    if (global.egg_attempts > 0 && (room == room_dw_city_traffic_3 || room == room_dw_city_moss || room == room_dw_city_man))
    {
        if (room != room_dw_city_man)
#endif
#if CHAPTER_1 || CHAPTER_2
            draw_set_color(c_white);

        draw_text_outline(text_x, final_y + 75, "Egg Attempts: " + string(global.egg_attempts));
        draw_set_color(c_yellow);
    }
#endif
#if CHAPTER_2
    else if (global.mspipis_attempts > 0 && room == room_dw_mansion_dining3 && scr_sideb_get_phase() >= 3)
    {
        if (!global.mspipis_encountered)
            draw_set_color(c_white);
        
        draw_text_outline(text_x, final_y + 75, "Ms. Pipis Attempts: " + string(global.mspipis_attempts));
        draw_set_color(c_yellow);
    }
#endif

    if (global.starring_goals)
    {
        draw_text_outline(text_x, final_y + 90, "* Click or press      on goals to star them. *");
        draw_text_outline(text_x, final_y + 105, "* ESC,      : Cancel *");
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[4]), 0, round(text_x - string_width("     on goals to star them. *")), round(final_y + 92), 1, 1, 0, c_yellow, 1);
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[5]), 0, round(text_x - string_width("     : Cancel *")), round(final_y + 107), 1, 1, 0, c_yellow, 1);
    }
}

if (global.chat_typing)
{
    if (!global.is_console)
    {
        var len = array_length(chat_history);

        if (len > 0)
        {
            if (scr_check_pressed(vk_up, gp_padu))
            {
                if (chat_history_index == -1)
                    current_str = keyboard_string;
                else
                    chat_history[chat_history_index] = keyboard_string;

                if (++chat_history_index >= len)
                    chat_history_index = -1;

                if (chat_history_index == -1)
                    keyboard_string = current_str;
                else
                    keyboard_string = chat_history[chat_history_index];
            }
            else if (scr_check_pressed(vk_down, gp_padd))
            {
                if (chat_history_index == -1)
                    current_str = keyboard_string;
                else
                    chat_history[chat_history_index] = keyboard_string;

                if (--chat_history_index < -1)
                    chat_history_index = len - 1;

                if (chat_history_index == -1)
                    keyboard_string = current_str;
                else
                    keyboard_string = chat_history[chat_history_index];
            }
        }

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
        draw_text_outline_ext(1, surface_height - 63, "Typing in chat. Press ESC or      to cancel.\nCommands: " + command_list + ".", 15, surface_width);
        draw_sprite_ext(scr_getbuttonsprite(global.input_g[5]), 0, round(string_width("Typing in chat. Press ESC or ")), round(surface_height - 61), 1, 1, 0, c_ltgray, 1);
        draw_set_color(c_dkgray);
        ossafe_fill_rectangle(0, surface_height - 30, surface_width, surface_height);
        draw_set_color(c_white);
        draw_text_outline_ext(1, surface_height - 32, ((global.time % 30) < 15) ? (shown_str + "_") : shown_str, 15, surface_width);
    }

    if (keyboard_check_pressed(vk_enter) || mystring != "")
    {
        var str = string_trim(global.is_console ? mystring : keyboard_string);

        if (string_length(str) > 0)
        {
            if (!global.is_console)
                array_insert(init_chat_history, 0, str);

            str = scr_escape_string(str);
            var split_string = string_split(string_lower(str), " ", true);

            switch (split_string[0])
            {
                case "/color":
                case "/colour":
                    var chosen_color = (array_length(split_string) > 1) ? split_string[1] : "blank";

                    if (chosen_color == "blank" || scr_color_from_name(chosen_color) == c_white)
                    {
                        scr_chat_message(c_red, "Invalid color. Use orange, red, blue, green, purple, navy, teal, brown, pink or yellow.");
                    }
                    else if (chosen_color == global.color)
                    {
                        scr_chat_message(c_red, "You are already " + chosen_color + ".");
                    }
                    else
                    {
                        global.color = chosen_color;
                        scr_save_bingo_data();
                        ossafe_http_post("https://bingosync.com/api/color", "{ \"room\": \"" + global.room_id + "\", \"color\": \"" + global.color + "\" }");
                    }
                    break;

                case "/star":
                    if (!global.show_board || !board_revealed)
                    {
                        scr_chat_message(c_red, "You can't star goals while the board is hidden.");
                    }
                    else
                    {
                        global.starring_goals = true;
                        scr_show_mouse_at(window_get_width() / 2, window_get_height() / 2);
                    }
                    break;

                case "/autoconnect":
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
                    break;

                case "/fogofwar":
                    var param = (array_length(split_string) > 1) ? split_string[1] : "";

                    if (string_digits(param) == "")
                    {
                        if (param == "off")
                        {
                            if (global.fog_of_war == 0)
                            {
                                scr_chat_message(c_red, "Fog of War mode is already disabled.");
                            }
                            else
                            {
                                global.fog_of_war = 0;
                                scr_chat_message(c_yellow, "Fog of War mode disabled.");
                                scr_save_bingo_data();
                            }
                        }
                        else
                        {
                            scr_chat_message(c_red, "Invalid argument. Type a number between 1 and 24 or off.");
                        }
                    }
                    else
                    {
                        param = real(param);

                        if (param < 1 || param > 24)
                        {
                            scr_chat_message(c_red, "Invalid argument. Type a number between 1 and 24 or off.");
                        }
                        else if (param == global.fog_of_war)
                        {
                            scr_chat_message(c_red, "You already have Fog of War mode set to tier " + string(param) + ".");
                        }
                        else
                        {
                            var tier_str = "";

                            switch (param)
                            {
                                case 1:
                                    tier_str = "1";
                                    break;

                                case 2:
                                    tier_str = "1&2";
                                    break;

                                default:
                                    tier_str = "1-" + string(param);
                                    break;
                            }

                            global.fog_of_war = param;
                            scr_chat_message(c_yellow, "Fog of War mode enabled. You will only see tier " + tier_str + " goals and goals around those that are marked.");
                            scr_save_bingo_data();
                        }
                    }
                    break;

                case "/settings":
                    if (!instance_exists(obj_bingo_settings_screen))
                    {
                        instance_create_depth(0, 0, -1, obj_bingo_settings_screen);
                        scr_show_mouse_at((window_get_width() / 2) + 5, window_get_height() / 2);
                    }
                    break;

                case "/quit":
                    with (instance_create_depth(0, 0, -16000, obj_fullscreen_fadeout))
                        fadespeed = 0.16;

                    call_later(12, time_source_units_frames, function()
                    {
                        scr_chapterswitch(0);
                    });
                    break;

                default:
                    if (string_pos("/", split_string[0]) == 1)
                        scr_chat_message(c_red, "That command doesn't exist.");
                    else
                        ossafe_http_post("https://bingosync.com/api/chat", "{ \"room\": \"" + global.room_id + "\", \"text\": \"" + str + "\" }");
                    break;
            }
        }

        global.chat_typing = false;
        keyboard_clear(vk_enter);
        mystring = "";
        chat_history = [];
        chat_history_index = -1;
    }
}

scr_set_temp_draw();