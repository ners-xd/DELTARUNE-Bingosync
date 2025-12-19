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
                    obj_time.mouse_visible = true;
                    
                    with (obj_bingo_setup)
                        error_show("Couldn't connect to Bingosync...\nTry again later.");
                    
                    network_destroy(global.ws_client);
                    global.ws_client = -1;
                    instance_destroy();
                    exit;
                }

                var buffer = buffer_create(40, buffer_fixed, 1);
                buffer_write(buffer, buffer_text, global.ws_key);
                network_send_raw(global.ws_client, buffer, 40);
                buffer_delete(buffer);
                alarm[0] = 1;
                ossafe_http_post("https://bingosync.com/api/color", "{ \"room\": \"" + global.room_id + "\", \"color\": \"" + global.color + "\" }");
                http_room_settings = http_get("https://bingosync.com/room/" + global.room_id + "/room-settings");
                http_feed = ossafe_http_get("https://bingosync.com/room/" + global.room_id + "/feed");
                draw_set_halign(fa_left);
                draw_set_valign(fa_top);
                audio_stop_all();
                room_goto(obj_initializer2.roomchoice);
                exit;

            case network_type_data:
                var data = ds_map_find_value(async_load, "buffer");
                buffer_seek(data, buffer_seek_start, 0);
                var json = json_parse(buffer_read(data, buffer_text));

                switch (json.type)
                {
                    case "connection":
                        if (global.show_connections)
                            scr_chat_message(c_white, string(json.player.name + " " + json.event_type + "."));

                        break;

                    case "revealed":
                        if (global.show_reveals)
                            scr_chat_message(c_white, string(json.player.name + " revealed the card."));

                        break;

                    case "chat":
                        if (global.show_chats)
                            scr_chat_message(scr_color_from_name(json.player.color), string(json.player.name + ": " + string_copy(json.text, 1, 100)));

                        break;

                    case "color":
                        if (global.show_colors)
                            scr_chat_message(scr_color_from_name(json.player.color), string(json.player.name + " changed color to " + json.player.color + "."));

                        break;

                    case "goal":
                        if (global.show_goal_marks)
                            scr_chat_message(c_white, string(json.player.name + (json.remove ? " cleared " : " marked ") + "\"" + json.square.name + "\"."));

                        break;

                    case "new-card":
                        if (global.show_new_cards)
                            scr_chat_message(c_yellow, string(json.player.name + " generated a new card (seed: " + (json.hide_card ? "hidden" : json.seed) + "). Your progress was reset."));
                        
                        global.room_seed = -1;
                        http_room_settings = http_get("https://bingosync.com/room/" + global.room_id + "/room-settings");
                        alarm[0] = 3 * room_speed;
                        global.last_card_timestamp = json.timestamp;
                        scr_reset_bingo_data();
                        break;
                }

                exit;
        }
    }
}
catch (e)
{
}
