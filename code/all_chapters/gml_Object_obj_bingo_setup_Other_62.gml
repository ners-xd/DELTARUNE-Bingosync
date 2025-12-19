/// IMPORT

try
{
    if (ds_map_find_value(async_load, "id") == httppost)
    {
        var http_status = ds_map_find_value(async_load, "http_status");
        var info = ds_map_find_value(async_load, "result");
        var info_str = string(info);

        if (global.is_console && http_status == 302)
        {
            var headers = ds_map_find_value(async_load, "response_headers");

            if (!ds_exists(headers, ds_type_map) || ds_map_empty(headers))
            {
                obj_time.mouse_visible = true;
                error_show("Couldn't connect to Bingosync...\nTry again later.");
            }
            else
            {
                global.cookie_sessionid = ds_map_create();
                ds_map_add(global.cookie_sessionid, "Cookie", ds_map_find_value(headers, "Set-Cookie"));
                httppost = http_request("https://bingosync.com" + ds_map_find_value(headers, "Location"), "GET", global.cookie_sessionid, "");
            }
        }
        else if (http_status == 200)
        {
            global.ws_key = info;

            if (!instance_exists(obj_bingo_controller))
                instance_create_depth(0, 0, 0, obj_bingo_controller);
        }
        else if (string_pos("Sorry, that page doesn't exist!", info_str) > 0)
        {
            obj_time.mouse_visible = true;
            error_show("Invalid room ID!");
        }
        else if (string_pos("Incorrect Password", info_str) > 0)
        {
            obj_time.mouse_visible = true;
            error_show("Incorrect password!");
        }
        else if (string_pos("socket_key", info_str) == 0)
        {
            // Delaying this because sometimes it would show up even if you did successfully connect,
            // moments before putting you in the intro room
            call_later(1, 0, function()
            {
                obj_time.mouse_visible = true;

                with (obj_bingo_setup)
                    error_show("Couldn't connect to Bingosync...\nTry again later.");
            });
        }
    }
}
catch (e)
{
}