/// IMPORT

try
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
        switch (ds_map_find_value(async_load, "id"))
        {
            case http_board:
                var info = json_parse(ds_map_find_value(async_load, "result"));
                var entry = 0;

                for (var i = 0; i < array_length(info); i++)
                {
                    entry = info[i];
                    global.goal_name[i] = string_trim(entry.name);
                    global.goal_slot[i] = entry.slot;

                    if (update_colors)
                        global.goal_colors[i] = entry.colors;
                }

                update_colors = true;
                board_done = true;
                break;

            case http_room_settings:
                var info = json_parse(ds_map_find_value(async_load, "result"));
                global.room_seed = info.settings.seed;
                global.room_lockout = info.settings.lockout_mode;
                board_revealed = !info.settings.hide_card;
                room_settings_done = true;
                break;

            case http_feed:
                var info = json_parse(ds_map_find_value(async_load, "result"));

                for (var i = array_length(info.events) - 1; i >= 0; i--)
                {
                    if (info.events[i].type == "new-card" && info.events[i].is_current)
                    {
                        if (info.events[i].timestamp > global.last_card_timestamp)
                        {
                            if (global.last_card_timestamp > 0)
                                scr_chat_message(c_yellow, "Your progress was reset because the board has changed since you last played.");

                            global.last_card_timestamp = info.events[i].timestamp;
                            scr_reset_bingo_data();
                        }
                        break;
                    }
                }

                feed_done = true;
                break;

            case http_room_base:
                var info = ds_map_find_value(async_load, "result");
                var search_start = "<a href=\"/\">Bingosync</a> - ";
                var search_start_len = string_length(search_start);
                var pos_start = string_pos(search_start, info);

                if (pos_start > 0)
                {
                    var pos_end = string_pos_ext("</h1>", info, pos_start);

                    if (pos_end > 0)
                    {
                        var room_name = scr_html_decode(string_copy(info, pos_start + search_start_len, pos_end - pos_start - search_start_len));
                        var arr_index = array_find_index_temp(global.room_history, function(element)
                        {
                            return element.room_id == global.room_id;
                        });

                        if (arr_index == -1)
                        {
                            global.room_history[array_length(global.room_history)] = 
                            {
                                name: room_name,
                                room_id: global.room_id,
                                password: global.password,
                                last_accessed: date_current_datetime()
                            };
                        }
                        else
                        {
                            global.room_history[arr_index].last_accessed = date_current_datetime();
                        }

                        array_sort(global.room_history, function(current, next)
                        {
                            return (next.last_accessed - current.last_accessed) > 0;
                        });
                        scr_save_bingo_data();
                    }
                }

                room_base_done = true;
                break;
        }
    }
}
catch (e)
{
}