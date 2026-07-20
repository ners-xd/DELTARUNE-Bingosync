/// IMPORT

persistent = true;
width = surface_get_width(application_surface);
height = surface_get_height(application_surface);
dw = display_get_width();
dh = display_get_height();
draw_close_x = width / 2;
draw_close_y = height - 10;
error_text = "";
clicked_button = noone;
assigning_keybind = "";

function bg_draw()
{
    exit;
}

function error_show(msg)
{
    error_text = msg;
    snd_play(snd_hurt1);
}

function reset_menu()
{
    instance_destroy();
    instance_create_depth(0, 0, depth, obj_bingo_settings_screen);
}

var _width = width / 2;
var _height = height / 2;
var show_connections_button = instance_create_depth(_width - 270, _height - 160, depth - 1, obj_bingoscreen_button);
var show_reveals_button = instance_create_depth(_width - 270, _height - 110, depth - 1, obj_bingoscreen_button);
var show_chats_button = instance_create_depth(_width - 270, _height - 60, depth - 1, obj_bingoscreen_button);
var show_colors_button = instance_create_depth(_width - 270, _height - 10, depth - 1, obj_bingoscreen_button);
var show_goal_marks_button = instance_create_depth(_width - 270, _height + 40, depth - 1, obj_bingoscreen_button);
var show_new_cards_button = instance_create_depth(_width - 270, _height + 90, depth - 1, obj_bingoscreen_button);
var show_hits_button = instance_create_depth(_width - 270, _height + 140, depth - 1, obj_bingoscreen_button);
var card_toggle_button = instance_create_depth(_width + 69, _height - 160, depth - 1, obj_bingoscreen_button);
var chat_button = instance_create_depth(_width + 69, _height - 100, depth - 1, obj_bingoscreen_button);
var card_reveal_button = instance_create_depth(_width + 69, _height - 40, depth - 1, obj_bingoscreen_button);
var chat_toggle_button = instance_create_depth(_width + 69, _height + 20, depth - 1, obj_bingoscreen_button);
var color_hide_button = instance_create_depth(_width + 69, _height + 80, depth - 1, obj_bingoscreen_button);
var import_saves_button = instance_create_depth(_width + 69, _height + 140, depth - 1, obj_bingoscreen_button);
var delete_saves_button = instance_create_depth(_width + 172, _height + 140, depth - 1, obj_bingoscreen_button);

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
        obj_bingo_settings_screen.clicked_button = id;
        obj_bingo_settings_screen.assigning_keybind = "board_key";
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
        obj_bingo_settings_screen.clicked_button = id;
        obj_bingo_settings_screen.assigning_keybind = "chat_key";
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
        obj_bingo_settings_screen.clicked_button = id;
        obj_bingo_settings_screen.assigning_keybind = "reveal_key";
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
        obj_bingo_settings_screen.clicked_button = id;
        obj_bingo_settings_screen.assigning_keybind = "toggle_chat_key";
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
        obj_bingo_settings_screen.clicked_button = id;
        obj_bingo_settings_screen.assigning_keybind = "color_hide_key";
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
            error_show("\n\n\nNo vanilla DELTARUNE\nsave data found.");
            exit;
        }

        with (obj_bingoscreen_button)
            instance_destroy();

        with (obj_bingo_settings_screen)
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

        var _width = obj_bingo_settings_screen.width / 2;
        var _height = obj_bingo_settings_screen.height / 2;
        var yes_button = instance_create_depth(_width - 60, _height - 10, depth - 1, obj_bingoscreen_button);
        var no_button = instance_create_depth(_width - 60, _height + 30, depth - 1, obj_bingoscreen_button);

        with (yes_button)
        {
            x2 = x + 120;
            y2 = y + 30;
            text = "Yes";

            on_click = function()
            {
                if (!vanilla_directory_exists())
                {
                    error_show("\n\n\nNo vanilla DELTARUNE\nsave data found.");
                    exit;
                }

                with (obj_initializer2)
                    roomchoice = scr_get_starting_room();

                with (obj_bingo_settings_screen)
                    reset_menu();

                scr_import_vanilla_files();
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
                with (obj_bingo_settings_screen)
                    reset_menu();
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

        with (obj_bingo_settings_screen)
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

        var _width = obj_bingo_settings_screen.width / 2;
        var _height = obj_bingo_settings_screen.height / 2;
        var yes_button = instance_create_depth(_width - 60, _height - 10, depth - 1, obj_bingoscreen_button);
        var no_button = instance_create_depth(_width - 60, _height + 30, depth - 1, obj_bingoscreen_button);

        with (yes_button)
        {
            x2 = x + 120;
            y2 = y + 30;
            text = "Yes";

            on_click = function()
            {
                with (obj_bingo_settings_screen)
                    reset_menu();
                
                scr_delete_save_files();
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
                with (obj_bingo_settings_screen)
                    reset_menu();
            };
        }
    };
}

function draw_event()
{
    scr_get_temp_draw();

    if (!instance_exists(obj_bingo_setup))
    {
        draw_set_alpha(0.5);
        draw_set_color(c_black);
        ossafe_fill_rectangle(-dw, -dh, dw, dh);
    }

    draw_set_alpha(1);
    draw_set_font(fnt_mainbig);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_outline(width / 2, 40, "SETTINGS & KEYBINDS");
    draw_set_font(fnt_main);

    if (error_text != "")
    {
        draw_set_color(c_red);
        draw_text_outline_ext(width / 2, height - 60, error_text, 15, width);
    }

    bg_draw();
    draw_set_color(c_ltgray);
    var gp_key = scr_input_name_gp(global.input_g[5]);

    if (is_string(gp_key))
    {
        draw_text_outline(draw_close_x, draw_close_y, "Press ESC or " + gp_key + " to go back.");
    }
    else
    {
        var before_text = "Press ESC or";
        var after_text = "to go back.";
        var total_w = string_width(before_text) + sprite_get_width(gp_key) + string_width(after_text);
        draw_text_outline(draw_close_x, draw_close_y, "Press ESC or      to go back.");
        draw_sprite_ext(gp_key, 0, round((draw_close_x - (total_w / 2)) + string_width(before_text)), draw_close_y - 7, 1, 1, 0, c_ltgray, 1);
    }

    if (assigning_keybind != "")
    {
        draw_set_color(c_yellow);
        draw_text_outline(draw_close_x, draw_close_y - 25, "Listening...");
    }

    scr_set_temp_draw();
}