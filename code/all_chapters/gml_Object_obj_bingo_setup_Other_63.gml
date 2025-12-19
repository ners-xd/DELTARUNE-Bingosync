/// IMPORT
// Taken from UNDERTALE (Switch) Mettaton Essay Question

if (ds_map_find_value(async_load, "id") == async_string)
{
    var str = "";

    if (ds_map_find_value(async_load, "status"))
    {
        var input_str = ds_map_find_value(async_load, "result");
        var input_len = strlen(input_str);

        for (var i = 1; i <= input_len; i++)
        {
            var ch = ord(string_char_at(input_str, i));
            var ok = false;

            if ((ch >= 32 && ch <= 126) || (ch >= 12288 && ch <= 12290) || (ch >= 12300 && ch <= 12305) || (ch >= 12353 && ch <= 12435) || (ch >= 12449 && ch <= 12531) || (ch == 12539 || ch == 12540) || ch == 65374 || (ch >= 65377 && ch <= 65439))
            {
                ok = true;
            }
            else if (ch == 8216)
            {
                ch = 96;
                ok = true;
            }
            else if (ch == 8217)
            {
                ch = 39;
                ok = true;
            }
            else if (ch == 8220 || ch == 8221)
            {
                ch = 34;
                ok = true;
            }
            else if (ch == 12316)
            {
                ch = 65374;
                ok = true;
            }
            else if (ch >= 65281 && ch < 65374)
            {
                ch -= 65248;
                ok = true;
            }

            if (ok)
                str += chr(ch);
        }

        str = scr_escape_string(str);

        switch (clicked_button)
        {
            case room_id_button:
                global.room_id = string_copy(string_trim(str), 1, 22);
                clicked_button.text = "Room ID:\n" + global.room_id;
                break;

            case room_password_button:
                global.password = str;
                break;

            case nickname_button:
                global.nickname = string_copy(string_trim(str), 1, 50);
                clicked_button.text = "Nickname:\n" + global.nickname;
                break;
        }

        scr_save_bingo_data();
    }

    async_string = -1;
    clicked_button = noone;
    obj_time.mouse_visible = true;
}