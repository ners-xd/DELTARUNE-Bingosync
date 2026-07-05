/// IMPORT

scr_load_bingo_data();
network_set_config(network_config_connect_timeout, 10000);
global.ws_client = -1;
global.ws_key = "{}";
global.grazed_at_all = false;
global.hits_frame_delay = -1;
global.buy_frame_delay = -1;
#if CHAPTER_1
global.clover_manual = false;
#elsif CHAPTER_2
global.failed_pot_balance = false;
global.teacupshit = false;
#elsif CHAPTER_3
global.knight_swords_hit = false;
#elsif CHAPTER_4
global.forcedswords = false;
global.balthizard_clouds = false;
#endif
global.cookie_sessionid = -1;
httppost = -1;
status_color = c_ltgray;
status_text = "";
async_string = -1;
width = surface_get_width(application_surface);
height = surface_get_height(application_surface);
draw_close_x = -1;
draw_close_y = -1;
assigning_keybind = "";
clicked_button = noone;
room_id_button = noone;
room_password_button = noone;
nickname_button = noone;
random_text = "";

function error_show(msg)
{
    obj_time.mouse_visible = true;
    status_color = c_red;
    status_text = msg;
    snd_play(snd_hurt1);
}

function bg_draw()
{
    exit;
}

function connect_to_room()
{
    if (!obj_time.internet)
    {
        error_show("Can't connect without internet!");
    }
    else if (global.room_id == "")
    {
        error_show("No room ID set!");
    }
    else if (global.password == "")
    {
        error_show("No password set!");
    }
    else if (global.nickname == "")
    {
        error_show("No name set!");
    }
    else if (global.color == "")
    {
        error_show("No color set!");
    }
    else
    {
        obj_time.mouse_visible = false;
        httppost = http_post_string("https://bingosync.com/api/join-room", "{ \"room\": \"" + global.room_id + "\", \"nickname\": \"" + global.nickname + "\", \"password\": \"" + global.password + "\" }");
        status_color = c_yellow;
        status_text = "Please wait...";
    }
}

function draw_main_buttons()
{
    var connect_button = instance_create_depth((width / 2) - 210, (height / 2) + 25, depth - 1, obj_bingoscreen_button);
    var room_info_button = instance_create_depth((width / 2) - 210, (height / 2) + 86, depth - 1, obj_bingoscreen_button);
    var settings_button = instance_create_depth((width / 2) + 9, (height / 2) + 25, depth - 1, obj_bingoscreen_button);
    var chapter_select_button = instance_create_depth((width / 2) + 9, (height / 2) + 86, depth - 1, obj_bingoscreen_button);
    var mod_credits_button = instance_create_depth(width - 83, height - 55, depth - 1, obj_bingoscreen_button);

    with (connect_button)
    {
        x2 = x + 200;
        y2 = y + 51;
        sprite = spr_room_connect_icon;
        text = "Connect to room";

        if (global.room_id == "" || global.nickname == "" || global.color == "")
            hover_text = "Connect to the room provided in the Room & User Info section.\nYou haven't set a room ID, name or color yet.";
        else
            hover_text = "Connect to room " + global.room_id + " as\n" + global.nickname + " (" + global.color + ").";

        on_click = function()
        {
            with (obj_bingo_setup)
                connect_to_room();

            with (obj_bingoscreen_button)
                hovering = (id == other.id);
        };
    }

    with (room_info_button)
    {
        x2 = x + 200;
        y2 = y + 51;
        sprite = spr_room_user_info_icon;
        text = "Room & User Info";
        hover_text = "Set your room ID / password, name and color here.";

        on_click = function()
        {
            with (obj_bingoscreen_button)
                instance_destroy();

            with (obj_bingo_setup)
            {
                room_id_button = instance_create_depth((width / 2) - 180, (height / 2) - 160, depth - 1, obj_bingoscreen_button);
                room_password_button = instance_create_depth((width / 2) - 180, (height / 2) - 100, depth - 1, obj_bingoscreen_button);
                nickname_button = instance_create_depth((width / 2) - 180, (height / 2) - 40, depth - 1, obj_bingoscreen_button);
                draw_close_x = width / 2;
                draw_close_y = height - 10;
                status_text = "";
                var timezone = date_get_timezone();
                date_set_timezone(timezone_utc);
                random_text = choose(
                    "Hello everyone.",
                    "No one plays Chapter 4!",
                    "SURVEY_PROGRAM sucks!",
                    "SURVEY_PROGRAM rocks!",
                    "holy moly",
                    "**** you ners",
                    "It's a low 59!",
                    "Too many inside jokes...",
                    "skill issue",
                    "I'm old!",
                    "Deltarune if it was good",
                    "[Fr33 fr13nd f1ndh3r]",
                    "I couldn't find my hand.",
                    "YOUR TAKING TOO LONG",
                    "YOUR TAKING TOO TOO",
                    "your taking too long IS TAKING TOO LONG",
                    "YOUR LONG",
                    "It's been " + string(floor(date_day_span(date_create_datetime(2018, 10, 31, 13, 0, 0), date_current_datetime()))) + " days since Chapter 1!",
                    "It's been " + string(floor(date_day_span(date_create_datetime(2021, 9, 18, 0, 0, 0), date_current_datetime()))) + " days since Chapter 2!",
                    "It's been " + string(floor(date_day_span(date_create_datetime(2025, 6, 4, 15, 0, 0), date_current_datetime()))) + " days since Chapters 3+4!",
                    "It's been " + string(floor(date_day_span(date_create_datetime(2026, 6, 24, 15, 0, 0), date_current_datetime()))) + " days since Chapter 5!",
                    "I am a fast little boy!",
                    obj_time.controller_used ? "Controller is based." : "Keyboard is based.",
                    obj_time.controller_used ? "Keyboard is not based." : "Controller is not based.",
                    "There's a friend inside me.",
                    "There's a friend inside you.",
                    "Don't forget to fight the dummy!",
                    "jarona",
                    "stingus"
                );
                date_set_timezone(timezone);

                bg_draw = function()
                {
                    draw_set_font(fnt_mainbig);
                    draw_set_color(c_white);
                    draw_text_outline(width / 2, 40, "ROOM & USER INFO");
                    draw_set_font(fnt_main);
                    draw_text_outline(width / 2, height - 205, "Name color:");

                    if (global.nickname != "" && global.color != "")
                    {
                        draw_text_outline(width / 2, height - 90, "This is how your chat messages will look like:");
                        draw_set_color(scr_color_from_name(global.color));
                        draw_text_outline(width / 2, height - 75, global.nickname + ": " + random_text);
                    }
                };

                with (room_id_button)
                {
                    x2 = x + 357;
                    y2 = y + 50;
                    text = "Room ID:" + (global.room_id == "" ? " [Empty]" : ("\n" + global.room_id));

                    on_click = function()
                    {
                        cursor_sprite = spr_maus_cursor;
                        obj_time.mouse_visible = false;
                        obj_bingo_setup.clicked_button = id;
                        obj_bingo_setup.mystring = "";
                        obj_bingo_setup.async_string = get_string_async("Input the room ID (22 characters).", global.room_id);
                    };
                }

                with (room_password_button)
                {
                    x2 = x + 357;
                    y2 = y + 50;
                    text = "Room Password:" + (global.password == "" ? " [Empty]" : "\nClick to view");

                    on_click = function()
                    {
                        cursor_sprite = spr_maus_cursor;
                        obj_time.mouse_visible = false;
                        obj_bingo_setup.clicked_button = id;
                        obj_bingo_setup.mystring = "";
                        obj_bingo_setup.async_string = get_string_async("Input the room password.", global.password);
                    };
                }

                with (nickname_button)
                {
                    x2 = x + 357;
                    y2 = y + 50;
                    text = "Name:" + (global.nickname == "" ? " [Empty]" : ("\n" + global.nickname));

                    on_click = function()
                    {
                        cursor_sprite = spr_maus_cursor;
                        obj_time.mouse_visible = false;
                        obj_bingo_setup.clicked_button = id;
                        obj_bingo_setup.mystring = "";
                        obj_bingo_setup.async_string = get_string_async("Input your name (maximum 50 characters).", global.nickname);
                    };
                }
            }

            var _width = obj_bingo_setup.width / 2;
            var _height = obj_bingo_setup.height / 2;
            var room_history_button = instance_create_depth(_width + 185, _height - 160, depth, obj_bingoscreen_button);
            var orange_button = instance_create_depth(_width - 95, _height + 50, depth, obj_bingoscreen_button);
            var red_button = instance_create_depth(_width - 55, _height + 50, depth, obj_bingoscreen_button);
            var blue_button = instance_create_depth(_width - 15, _height + 50, depth, obj_bingoscreen_button);
            var green_button = instance_create_depth(_width + 25, _height + 50, depth, obj_bingoscreen_button);
            var purple_button = instance_create_depth(_width + 65, _height + 50, depth, obj_bingoscreen_button);
            var navy_button = instance_create_depth(_width - 95, _height + 90, depth, obj_bingoscreen_button);
            var teal_button = instance_create_depth(_width - 55, _height + 90, depth, obj_bingoscreen_button);
            var brown_button = instance_create_depth(_width - 15, _height + 90, depth, obj_bingoscreen_button);
            var pink_button = instance_create_depth(_width + 25, _height + 90, depth, obj_bingoscreen_button);
            var yellow_button = instance_create_depth(_width + 65, _height + 90, depth, obj_bingoscreen_button);

            with (room_history_button)
            {
                x2 = x + 60;
                y2 = y + 50;
                text = "Room\nHistory";
                obj_bingo_setup.history_len = array_length(global.room_history);

                on_click = function()
                {
                    with (obj_bingo_setup)
                    {
                        if (history_len < 1)
                        {
                            error_show("There is no room history to show.");
                            exit;
                        }

                        with (obj_bingoscreen_button)
                            instance_destroy();

                        history_page = 0;
                        max_history_entries = 5;
                        max_history_page = history_len div max_history_entries;
                        draw_close_x = width / 2;
                        draw_close_y = height - 10;

                        bg_draw = function()
                        {
                            draw_set_font(fnt_mainbig);
                            draw_set_color(c_white);
                            draw_text_outline(width / 2, 40, "ROOM HISTORY");
                            draw_set_font(fnt_main);
                            draw_text_outline(width / 2, height - 50, "Click on any room to import its ID and password.");

                            if (history_len > max_history_entries)
                            {
                                draw_text_outline(width / 2, 60, "Page " + string(history_page + 1) + "/" + string(max_history_page + 1));
                                draw_text_outline(width / 2, height - 35, obj_time.controller_used ? "Press LEFT and RIGHT (D-Pad) to switch pages." : "Press LEFT and RIGHT to switch pages.");
                                draw_set_font(fnt_mainbig);
                                var left = scr_check_pressed(vk_left, gp_padl);
                                var right = scr_check_pressed(vk_right, gp_padr);

                                if (left)
                                {
                                    if (--history_page < 0)
                                        history_page = max_history_page;

                                    draw_set_color(c_yellow);
                                    snd_play(snd_menumove);
                                }
                                else
                                {
                                    draw_set_color(c_white);
                                }
                                draw_text_outline((width / 2) - 220, height / 2, "<");

                                if (right && !left)
                                {
                                    if (++history_page > max_history_page)
                                        history_page = 0;

                                    draw_set_color(c_yellow);
                                    snd_play(snd_menumove);
                                }
                                else
                                {
                                    draw_set_color(c_white);
                                }
                                draw_text_outline((width / 2) + 223, height / 2, ">");
                                draw_set_font(fnt_main);
                            }
                        };

                        for (var i = 0; i < max_history_entries; i++)
                        {
                            with (instance_create_depth((width / 2) - 190, 95 + (i * 60), depth - 1, obj_bingoscreen_button))
                            {
                                x2 = x + 380;
                                y2 = y + 50;
                                start_index = i;
                                current_index = i;
                                outline_color = (obj_bingo_setup.history_len <= start_index) ? c_gray : c_white;

                                draw_on_top = function()
                                {
                                    draw_set_font(fnt_main);
                                    draw_set_halign(fa_center);
                                    draw_set_valign(fa_middle);
                                    current_index = (obj_bingo_setup.history_page * obj_bingo_setup.max_history_entries) + start_index;
                                    var mid_x = (x + x2) / 2;
                                    var mid_y = (y + y2) / 2;

                                    if (obj_bingo_setup.history_len <= current_index)
                                    {
                                        outline_color = c_gray;
                                        draw_set_color(hovering ? c_yellow : c_gray);
                                        draw_text_outline(mid_x, mid_y, "[Empty]");
                                    }
                                    else
                                    {
                                        outline_color = c_white;
                                        draw_set_color(hovering ? c_yellow : c_white);
                                        var current_name = global.room_history[current_index].name;

                                        if (string_length(current_name) > 50)
                                            current_name = string_copy(current_name, 1, 50) + "...";

                                        draw_text_outline_ext(mid_x, mid_y, current_name + "\n(" + global.room_history[current_index].room_id + ")\nLast joined on " + date_datetime_string(global.room_history[current_index].last_accessed), 15, 400);
                                    }
                                };

                                on_click = function()
                                {
                                    if (obj_bingo_setup.history_len <= current_index)
                                    {
                                        snd_play(snd_hurt1);
                                    }
                                    else
                                    {
                                        with (obj_bingo_setup)
                                        {
                                            global.room_id = global.room_history[other.current_index].room_id;
                                            global.password = global.room_history[other.current_index].password;
                                            scr_save_bingo_data();
                                            go_to_main_page(spr_room_user_info_icon);
                                        }
                                    }
                                };
                            }
                        }
                    }
                };
            }

            with (orange_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("orange");
                outline_color = (global.color == "orange") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "orange";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (red_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("red");
                outline_color = (global.color == "red") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "red";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (blue_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("blue");
                outline_color = (global.color == "blue") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "blue";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (green_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("green");
                outline_color = (global.color == "green") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "green";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (purple_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("purple");
                outline_color = (global.color == "purple") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "purple";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (navy_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("navy");
                outline_color = (global.color == "navy") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "navy";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (teal_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("teal");
                outline_color = (global.color == "teal") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "teal";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (brown_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("brown");
                outline_color = (global.color == "brown") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "brown";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (pink_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("pink");
                outline_color = (global.color == "pink") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "pink";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }

            with (yellow_button)
            {
                x2 = x + 30;
                y2 = y + 30;
                outline_size = 2;
                rectangle_color = scr_color_from_name("yellow");
                outline_color = (global.color == "yellow") ? c_lime : c_white;

                on_click = function()
                {
                    global.color = "yellow";
                    scr_save_bingo_data();

                    with (obj_bingoscreen_button)
                        outline_color = c_white;

                    outline_color = c_lime;
                };
            }
        };
    }

    with (settings_button)
    {
        x2 = x + 200;
        y2 = y + 51;
        sprite = spr_settings_icon;
        text = "Settings & Keybinds";
        hover_text = "Change various settings, keybinds and\nalter your save files here.";

        on_click = function()
        {
            with (obj_bingoscreen_button)
                instance_destroy();

            with (obj_bingo_setup)
            {
                draw_close_x = width / 2;
                draw_close_y = height - 10;
                status_text = "";

                bg_draw = function()
                {
                    draw_set_font(fnt_mainbig);
                    draw_set_color(c_white);
                    draw_text_outline(width / 2, 40, "SETTINGS & KEYBINDS");
                    draw_set_font(fnt_main);
                };
            }

            var _width = obj_bingo_setup.width / 2;
            var _height = obj_bingo_setup.height / 2;
            var show_connections_button = instance_create_depth(_width - 270, _height - 160, depth, obj_bingoscreen_button);
            var show_reveals_button = instance_create_depth(_width - 270, _height - 110, depth, obj_bingoscreen_button);
            var show_chats_button = instance_create_depth(_width - 270, _height - 60, depth, obj_bingoscreen_button);
            var show_colors_button = instance_create_depth(_width - 270, _height - 10, depth, obj_bingoscreen_button);
            var show_goal_marks_button = instance_create_depth(_width - 270, _height + 40, depth, obj_bingoscreen_button);
            var show_new_cards_button = instance_create_depth(_width - 270, _height + 90, depth, obj_bingoscreen_button);
            var show_hits_button = instance_create_depth(_width - 270, _height + 140, depth, obj_bingoscreen_button);
            var card_toggle_button = instance_create_depth(_width + 69, _height - 160, depth, obj_bingoscreen_button);
            var chat_button = instance_create_depth(_width + 69, _height - 100, depth, obj_bingoscreen_button);
            var card_reveal_button = instance_create_depth(_width + 69, _height - 40, depth, obj_bingoscreen_button);
            var chat_toggle_button = instance_create_depth(_width + 69, _height + 20, depth, obj_bingoscreen_button);
            var color_hide_button = instance_create_depth(_width + 69, _height + 80, depth, obj_bingoscreen_button);
            var import_saves_button = instance_create_depth(_width + 69, _height + 140, depth, obj_bingoscreen_button);
            var delete_saves_button = instance_create_depth(_width + 172, _height + 140, depth, obj_bingoscreen_button);

            with (show_connections_button)
            {
                x2 = x + 270;
                y2 = y + 40;
                text = "Show connection/disconnection messages:\n" + (global.show_connections ? "Yes" : "No");

                on_click = function()
                {
                    global.show_connections = !global.show_connections;
                    scr_save_bingo_data();
                    text = "Show connection/disconnection messages:\n" + (global.show_connections ? "Yes" : "No");
                };
            }

            with (show_reveals_button)
            {
                x2 = x + 270;
                y2 = y + 40;
                text = "Show card reveal messages:\n" + (global.show_reveals ? "Yes" : "No");

                on_click = function()
                {
                    global.show_reveals = !global.show_reveals;
                    scr_save_bingo_data();
                    text = "Show card reveal messages:\n" + (global.show_reveals ? "Yes" : "No");
                };
            }

            with (show_chats_button)
            {
                x2 = x + 270;
                y2 = y + 40;
                text = "Show chat messages from players:\n" + (global.show_chats ? "Yes" : "No");

                on_click = function()
                {
                    global.show_chats = !global.show_chats;
                    scr_save_bingo_data();
                    text = "Show chat messages from players:\n" + (global.show_chats ? "Yes" : "No");
                };
            }

            with (show_colors_button)
            {
                x2 = x + 270;
                y2 = y + 40;
                text = "Show color change messages:\n" + (global.show_colors ? "Yes" : "No");

                on_click = function()
                {
                    global.show_colors = !global.show_colors;
                    scr_save_bingo_data();
                    text = "Show color change messages:\n" + (global.show_colors ? "Yes" : "No");
                };
            }

            with (show_goal_marks_button)
            {
                x2 = x + 270;
                y2 = y + 40;
                text = "Show goal mark/clear messages:\n" + (global.show_goal_marks ? "Yes" : "No");

                on_click = function()
                {
                    global.show_goal_marks = !global.show_goal_marks;
                    scr_save_bingo_data();
                    text = "Show goal mark/clear messages:\n" + (global.show_goal_marks ? "Yes" : "No");
                };
            }

            with (show_new_cards_button)
            {
                x2 = x + 270;
                y2 = y + 40;
                text = "Show new card messages:\n" + (global.show_new_cards ? "Yes" : "No");

                on_click = function()
                {
                    global.show_new_cards = !global.show_new_cards;
                    scr_save_bingo_data();
                    text = "Show new card messages:\n" + (global.show_new_cards ? "Yes" : "No");
                };
            }

            with (show_hits_button)
            {
                x2 = x + 270;
                y2 = y + 40;
                text = "Show hit counter:\n" + (global.hit_counter ? "Yes" : "No");

                on_click = function()
                {
                    global.hit_counter = !global.hit_counter;
                    scr_save_bingo_data();
                    text = "Show hit counter:\n" + (global.hit_counter ? "Yes" : "No");
                };
            }

            with (card_toggle_button)
            {
                x2 = x + 200;
                y2 = y + 50;
                text = "Card toggle keybind:\n" + scr_input_name(global.board_key) + "\n ";
                gp_key = scr_input_name_gp(global.board_key_gp);

                if (is_string(gp_key))
                {
                    text = string_replace(text, "\n ", "\n" + gp_key);
                }
                else
                {
                    draw_on_top = function()
                    {
                        draw_sprite_ext(gp_key, 0, ((x + x2) / 2) - 6, y2 - sprite_get_height(gp_key) - 2, 1, 1, 0, hovering ? hover_color : c_white, 1);
                    };
                }

                on_click = function()
                {
                    first_frame_done = false;
                    obj_bingo_setup.clicked_button = id;
                    obj_bingo_setup.assigning_keybind = "board_key";
                    obj_time.mouse_visible = false;
                };
            }

            with (chat_button)
            {
                x2 = x + 200;
                y2 = y + 50;
                text = "Chat keybind:\n" + scr_input_name(global.chat_key) + "\n ";
                gp_key = scr_input_name_gp(global.chat_key_gp);

                if (is_string(gp_key))
                {
                    text = string_replace(text, "\n ", "\n" + gp_key);
                }
                else
                {
                    draw_on_top = function()
                    {
                        draw_sprite_ext(gp_key, 0, ((x + x2) / 2) - 6, y2 - sprite_get_height(gp_key) - 2, 1, 1, 0, hovering ? hover_color : c_white, 1);
                    };
                }

                on_click = function()
                {
                    first_frame_done = false;
                    obj_bingo_setup.clicked_button = id;
                    obj_bingo_setup.assigning_keybind = "chat_key";
                    obj_time.mouse_visible = false;
                };
            }

            with (card_reveal_button)
            {
                x2 = x + 200;
                y2 = y + 50;
                text = "Card reveal keybind:\n" + scr_input_name(global.reveal_key) + "\n ";
                gp_key = scr_input_name_gp(global.reveal_key_gp);

                if (is_string(gp_key))
                {
                    text = string_replace(text, "\n ", "\n" + gp_key);
                }
                else
                {
                    draw_on_top = function()
                    {
                        draw_sprite_ext(gp_key, 0, ((x + x2) / 2) - 6, y2 - sprite_get_height(gp_key) - 2, 1, 1, 0, hovering ? hover_color : c_white, 1);
                    };
                }

                on_click = function()
                {
                    first_frame_done = false;
                    obj_bingo_setup.clicked_button = id;
                    obj_bingo_setup.assigning_keybind = "reveal_key";
                    obj_time.mouse_visible = false;
                };
            }

            with (chat_toggle_button)
            {
                x2 = x + 200;
                y2 = y + 50;
                text = "Chat toggle keybind:\n" + scr_input_name(global.toggle_chat_key) + "\n ";
                gp_key = scr_input_name_gp(global.toggle_chat_key_gp);

                if (is_string(gp_key))
                {
                    text = string_replace(text, "\n ", "\n" + gp_key);
                }
                else
                {
                    draw_on_top = function()
                    {
                        draw_sprite_ext(gp_key, 0, ((x + x2) / 2) - 6, y2 - sprite_get_height(gp_key) - 2, 1, 1, 0, hovering ? hover_color : c_white, 1);
                    };
                }

                on_click = function()
                {
                    first_frame_done = false;
                    obj_bingo_setup.clicked_button = id;
                    obj_bingo_setup.assigning_keybind = "toggle_chat_key";
                    obj_time.mouse_visible = false;
                };
            }

            with (color_hide_button)
            {
                x2 = x + 200;
                y2 = y + 50;
                text = "Color toggle keybind:\n" + scr_input_name(global.color_hide_key) + "\n ";
                gp_key = scr_input_name_gp(global.color_hide_key_gp);

                if (is_string(gp_key))
                {
                    text = string_replace(text, "\n ", "\n" + gp_key);
                }
                else
                {
                    draw_on_top = function()
                    {
                        draw_sprite_ext(gp_key, 0, ((x + x2) / 2) - 6, y2 - sprite_get_height(gp_key) - 2, 1, 1, 0, hovering ? hover_color : c_white, 1);
                    };
                }

                on_click = function()
                {
                    first_frame_done = false;
                    obj_bingo_setup.clicked_button = id;
                    obj_bingo_setup.assigning_keybind = "color_hide_key";
                    obj_time.mouse_visible = false;
                };
            }

            with (import_saves_button)
            {
                x2 = x + 97;
                y2 = y + 40;
                text = "Import\nvanilla files";

                on_click = function()
                {
                    if (!vanilla_directory_exists())
                    {
                        with (obj_bingo_setup)
                            error_show("\n\n\nNo vanilla DELTARUNE\nsave data found.");

                        exit;
                    }

                    with (obj_bingoscreen_button)
                        instance_destroy();

                    with (obj_bingo_setup)
                    {
                        draw_close_x = width / 2;
                        draw_close_y = (height / 2) + 87;
                        status_text = "";

                        bg_draw = function()
                        {
                            draw_set_font(fnt_main);
                            draw_set_color(c_white);
                            draw_text_outline(width / 2, (height / 2) - 63, "Are you sure you want to replace your current\nsave data with your vanilla DELTARUNE data?");
                            draw_set_color(c_red);
                            draw_text_outline(width / 2, (height / 2) - 39, "This applies to every chapter and can not be undone!");
                        };
                    }

                    var _width = obj_bingo_setup.width / 2;
                    var _height = obj_bingo_setup.height / 2;
                    var yes_button = instance_create_depth(_width - 60, _height - 10, depth, obj_bingoscreen_button);
                    var no_button = instance_create_depth(_width - 60, _height + 30, depth, obj_bingoscreen_button);

                    with (yes_button)
                    {
                        x2 = x + 120;
                        y2 = y + 30;
                        text = "Yes";

                        on_click = function()
                        {
                            if (!vanilla_directory_exists())
                            {
                                with (obj_bingo_setup)
                                    error_show("\n\n\nNo vanilla DELTARUNE\nsave data found.");

                                exit;
                            }

                            scr_import_vanilla_files();

                            with (obj_initializer2)
                                roomchoice = scr_get_starting_room();

                            with (obj_bingo_setup)
                                go_to_main_page(spr_settings_icon);

                        #if CHAPTER_1
                            scr_windowcaption("DELTARUNE Chapter 1");
                        #endif
                            snd_stop(AUDIO_APPEARANCE);
                            snd_play(AUDIO_APPEARANCE);
                        };
                    }

                    with (no_button)
                    {
                        x2 = x + 120;
                        y2 = y + 30;
                        text = "No";

                        on_click = function()
                        {
                            with (obj_bingo_setup)
                                go_to_main_page(spr_settings_icon);
                        };
                    }
                };
            }

            with (delete_saves_button)
            {
                x2 = x + 97;
                y2 = y + 40;
                text = "Erase all\nsave files";
                text_color = c_red;

                on_click = function()
                {
                    with (obj_bingoscreen_button)
                        instance_destroy();

                    with (obj_bingo_setup)
                    {
                        draw_close_x = width / 2;
                        draw_close_y = (height / 2) + 87;
                        status_text = "";

                        bg_draw = function()
                        {
                            draw_set_font(fnt_main);
                            draw_set_color(c_white);
                            draw_text_outline(width / 2, (height / 2) - 63, "Are you sure you want to erase all of your\nsave files, not including completion data?");
                            draw_set_color(c_red);
                            draw_text_outline(width / 2, (height / 2) - 39, "This applies to every chapter and can not be undone!");
                        };
                    }

                    var _width = obj_bingo_setup.width / 2;
                    var _height = obj_bingo_setup.height / 2;
                    var yes_button = instance_create_depth(_width - 60, _height - 10, depth, obj_bingoscreen_button);
                    var no_button = instance_create_depth(_width - 60, _height + 30, depth, obj_bingoscreen_button);

                    with (yes_button)
                    {
                        x2 = x + 120;
                        y2 = y + 30;
                        text = "Yes";

                        on_click = function()
                        {
                            scr_delete_save_files();
                            
                            with (obj_bingo_setup)
                                go_to_main_page(spr_settings_icon);
                            
                            snd_stop(AUDIO_APPEARANCE);
                            snd_play(AUDIO_APPEARANCE);
                        };
                    }

                    with (no_button)
                    {
                        x2 = x + 120;
                        y2 = y + 30;
                        text = "No";

                        on_click = function()
                        {
                            with (obj_bingo_setup)
                                go_to_main_page(spr_settings_icon);
                        };
                    }
                };
            }
        };
    }

    with (chapter_select_button)
    {
        x2 = x + 200;
        y2 = y + 51;
        sprite = spr_chapter_icon;

#if CHAPTER_1 || CHAPTER_2
        sprite_frame = global.chapter - 1;
#elsif CHAPTER_3
        sprite_frame = 2 + scr_completed_chapter_any_slot(3);
#else
        sprite_frame = global.chapter;
#endif

        text = "Chapter Select";
        hover_text = "Exit the game and return to the Chapter Select menu.";

        on_click = function()
        {
            obj_time.mouse_visible = false;
            mus_volume(global.currentsong[1], 0, 6);

            with (instance_create(0, 0, obj_fadeout))
                fadespeed = 0.16;

            call_later(12, time_source_units_frames, function()
            {
                scr_chapterswitch(0);
            });
        };
    }

    with (mod_credits_button)
    {
        x2 = x + 80;
        y2 = y + 20;
        text = "Mod Credits";
        hover_text = "Bring up a pop-up with those who have\ncontributed to the Bingosync Mod!";

        on_click = function()
        {
            with (obj_bingoscreen_button)
                instance_destroy();

            with (obj_bingo_setup)
            {
                draw_close_x = (((width / 2) - 150) + (width / 2) + 150) / 2;
                draw_close_y = (height / 2) + 110;
                status_text = "";

                bg_draw = function()
                {
                    var _x1 = (width / 2) - 150;
                    var _x2 = (width / 2) + 150;
                    var _y1 = (height / 2) - 120;
                    var _y2 = (height / 2) + 120;
                    draw_set_color(c_white);
                    ossafe_fill_rectangle(_x1 - 3, _y1 - 3, _x2 + 3, _y2 + 3, false);
                    draw_set_color(c_black);
                    ossafe_fill_rectangle(_x1, _y1, _x2, _y2, false);
                    draw_set_color(c_white);
                    draw_set_font(fnt_mainbig);
                    draw_text(draw_close_x, _y1 + 15, "BINGOSYNC MOD CREDITS");
                    ossafe_fill_rectangle(_x1, _y1 + 30, _x2, _y1 + 33, false);
                    draw_set_font(fnt_main);
                    draw_set_color(c_ltgray);
                    draw_text(draw_close_x, _y1 + 60, "- Coding -");
                    draw_set_color(c_white);
                    draw_text(draw_close_x, _y1 + 75, "Main mod: Chistosito, NERS");
                    draw_text(draw_close_x, _y1 + 90, "Hit counter: marti005");
                    draw_set_color(c_ltgray);
                    draw_text(draw_close_x, _y1 + 120, "- Goal list -");
                    draw_set_color(c_white);
                    draw_text(draw_close_x, _y1 + 135, "Tadyman, Chistosito, Trinky44, devek1");
                    draw_set_color(c_ltgray);
                    draw_text(draw_close_x, _y1 + 165, "- Switch version testing -");
                    draw_set_color(c_white);
                    draw_text(draw_close_x, _y1 + 180, "Tadyman");
                };
            }
        };
    }
}

function go_to_main_page(spr)
{
    with (obj_bingoscreen_button)
        instance_destroy();

    draw_main_buttons();

    with (obj_bingoscreen_button)
    {
        if (sprite == spr)
        {
            on_click();
            break;
        }
    }
}

draw_main_buttons();
scr_show_mouse_at(window_get_width() / 2, window_get_height() / 2);

if (global.autoconnect && obj_time.internet)
{
    if (scr_check_held(ord("C"), gp_face4))
    {
        status_text = "Autoconnect cancelled.";
    }
    else
    {
        connect_to_room();
        status_text += "\n(Autoconnect)";
    }
}

global.currentsong[0] = snd_init("greenroom_detune.ogg");
global.currentsong[1] = mus_loop_ext(global.currentsong[0], 0.7, 1);

with (instance_create(0, 0, obj_fadein))
    fadespeed = -0.25;

if (global.is_console)
    application_surface_draw_enable(true);