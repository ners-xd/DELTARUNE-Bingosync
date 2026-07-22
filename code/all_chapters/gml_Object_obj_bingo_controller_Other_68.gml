/// IMPORT

try
{
    if (ds_map_find_value(async_load, "id") == global.ws_client)
    {
        switch (ds_map_find_value(async_load, "type"))
        {
            case network_type_non_blocking_connect:
                if (!ds_map_find_value(async_load, "succeeded"))
                {
                    with (obj_bingo_setup)
                        error_show("The connection has timed out...\nBingosync may be down or your internet may be too slow.\nTry again later.");

                    network_destroy(global.ws_client);
                    global.ws_client = -1;

                    if (instance_exists(obj_fullscreen_fadeout))
                    {
                        mus_volume(global.currentsong[1], 0.7, 8);
                        instance_destroy(obj_fullscreen_fadeout);

                        with (instance_create(0, 0, obj_fadein))
                            fadespeed = -0.16;
                    }

                    instance_destroy();
                    exit;
                }

                var buffer = buffer_create(40, buffer_fixed, 1);
                buffer_write(buffer, buffer_text, global.ws_key);
                network_send_raw(global.ws_client, buffer, 40);
                buffer_delete(buffer);
                event_perform(ev_alarm, 0);
                var escaped_room_id = scr_escape_string(global.room_id);
                ossafe_http_post("https://bingosync.com/api/color", "{ \"room\": \"" + escaped_room_id + "\", \"color\": \"" + global.color + "\" }");
                http_room_settings = http_get("https://bingosync.com/room/" + escaped_room_id + "/room-settings");
                http_feed = ossafe_http_get("https://bingosync.com/room/" + escaped_room_id + "/feed");
                http_room_base = ossafe_http_get("https://bingosync.com/room/" + escaped_room_id);
                draw_set_halign(fa_left);
                draw_set_valign(fa_top);
                snd_free_all();
                audio_stop_all();

                if (global.is_console)
                    application_surface_draw_enable(false);

                if (global.room_id != global.last_connected_room)
                {
                    var first_time = (global.last_connected_room == "");
                    global.last_connected_room = global.room_id;

                    if (!first_time)
                    {
                        global.last_card_timestamp = 0;
                        scr_chat_message(c_yellow, "Your progress was reset because you changed the room you're playing in.");
                        scr_reset_bingo_data();
                    }
                    else
                    {
                        scr_save_bingo_data();
                    }
                }
                break;

            case network_type_data:
                var data = ds_map_find_value(async_load, "buffer");
                buffer_seek(data, buffer_seek_start, 0);
                var json = json_parse(buffer_read(data, buffer_text));

                switch (json.type)
                {
                    case "connection":
                        if (global.show_connections)
                            scr_chat_message(c_white, json.player.name + " " + json.event_type + ".");
                        break;

                    case "revealed":
                        if (global.show_reveals)
                            scr_chat_message(c_white, json.player.name + " revealed the card.");
                        break;

                    case "chat":
                        if (global.show_chats)
                            scr_chat_message(scr_color_from_name(json.player.color), json.player.name + ": " + string_copy(json.text, 1, 100));
                        break;

                    case "color":
                        if (global.show_colors)
                            scr_chat_message(scr_color_from_name(json.player.color), json.player.name + " changed color to " + json.player.color + ".");
                        break;

                    case "goal":
                        if (global.show_goal_marks)
                        {
                            var str = "[" + current_board_time + "] " + json.player.name + (json.remove ? " cleared " : " marked ");
                            var slot = string_digits(json.square.slot);

                            if (scr_is_goal_visible(real(slot) - 1))
                                str += ("\"" + json.square.name + "\".");
                            else
                                str += ("square #" + slot + ".");

                            scr_chat_message(c_white, str);
                        }
                        break;

                    case "new-card":
                        if (global.show_new_cards)
                        {
                            var str = json.player.name + " generated a new card ";

                            if (string_ends_with(json.game, "Fixed Board"))
                                str += "(fixed board). Your progress was reset.";
                            else
                                str += ("(seed: " + (json.hide_card ? "hidden" : json.seed) + "). Your progress was reset.");

                            scr_chat_message(c_yellow, str);
                        }
                        
                        global.room_seed = -1;
                        http_room_settings = http_get("https://bingosync.com/room/" + scr_escape_string(global.room_id) + "/room-settings");
                        event_perform(ev_alarm, 0);
                        global.last_card_timestamp = json.timestamp;
                        scr_reset_bingo_data();
                        break;
                }
                break;
        }
    }
}
catch (e)
{
}