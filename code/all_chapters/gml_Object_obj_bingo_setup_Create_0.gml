/// IMPORT

scr_load_bingo_data();
global.ws_client = -1;
global.ws_key = "{}";
global.count_once = false;
global.grazed_at_all = false;
global.hits_frame_delay = -1;
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
pos = 0;
max_pos = 16;
sel = -1;
status_color = 0;
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
        error_show("No nickname set!");
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
            hover_text = "Connect to the room provided in the Room & User Info section.\nYou haven't set a room ID, nickname or color yet.";
        else
            hover_text = "Connect to room " + global.room_id + " as\n" + global.nickname + " (" + global.color + ").";

        on_click = function()
        {
            with (obj_bingo_setup)
                connect_to_room();
        };
    }

    with (room_info_button)
    {
        x2 = x + 200;
        y2 = y + 51;
        sprite = spr_room_user_info_icon;
        text = "Room & User Info";
        hover_text = "Set your room ID / password, nickname and color here.";

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
                    "It's been " + string(floor(date_day_span(date_create_datetime(2018, 10, 31, 0, 0, 0), date_current_datetime()))) + " days since Chapter 1!",
                    "It's been " + string(floor(date_day_span(date_create_datetime(2021, 9, 17, 0, 0, 0), date_current_datetime()))) + " days since Chapter 2!",
                    "It's been " + string(floor(date_day_span(date_create_datetime(2025, 6, 4, 0, 0, 0), date_current_datetime()))) + " days since Chapters 3+4!"
                );

                bg_draw = function()
                {
                    draw_set_font(fnt_mainbig);
                    draw_set_color(c_white);
                    draw_text_outline(width / 2, 40, "ROOM & USER INFO");
                    draw_set_font(fnt_main);
                    draw_text_outline(width / 2, height - 205, "Nickname color:");

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
                    text = "Room ID:\n" + global.room_id;

                    on_click = function()
                    {
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
                    text = "Room Password:\nClick to view";

                    on_click = function()
                    {
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
                    text = "Nickname:\n" + global.nickname;

                    on_click = function()
                    {
                        obj_time.mouse_visible = false;
                        obj_bingo_setup.clicked_button = id;
                        obj_bingo_setup.mystring = "";
                        obj_bingo_setup.async_string = get_string_async("Input your nickname (maximum 50 characters).", global.nickname);
                    };
                }
            }

            var _width = obj_bingo_setup.width / 2;
            var _height = obj_bingo_setup.height / 2;
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
        hover_text = "Change various settings and keybinds here.";

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
            var card_toggle_button = instance_create_depth(_width + 69, _height - 135, depth, obj_bingoscreen_button);
            var chat_button = instance_create_depth(_width + 69, _height - 75, depth, obj_bingoscreen_button);
            var card_reveal_button = instance_create_depth(_width + 69, _height - 15, depth, obj_bingoscreen_button);
            var chat_toggle_button = instance_create_depth(_width + 69, _height + 45, depth, obj_bingoscreen_button);
            var color_hide_button = instance_create_depth(_width + 69, _height + 105, depth, obj_bingoscreen_button);

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

            call_later(8, 1, function()
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

draw_main_buttons();

with (instance_create(0, 0, obj_fadein))
    fadespeed = -0.25;

if (global.autoconnect && obj_time.internet)
{
    connect_to_room();
    status_text = "Please wait...\n(Autoconnect)";
}
else
{
    scr_show_mouse_at(window_get_width() / 2, window_get_height() / 2);
}

global.currentsong[0] = snd_init("greenroom_detune.ogg");
global.currentsong[1] = mus_loop_ext(global.currentsong[0], 0.7, 1);