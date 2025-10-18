/// IMPORT .ignore if CHAPTER_1

if (prev_interact == 0 && mainchara_was_in_prev_room && instance_exists(obj_mainchara) && !obj_mainchara.roomenterfreezeend)
{
    var room_name = room_get_name(room);
    var len = array_length(global.wrong_warps);

    for (var i = 0; i < len; i++)
    {
        if (global.wrong_warps[i] == room_name)
        {
            exit;
        }
        else if (global.wrong_warps[i] == "")
        {
            global.wrong_warps[i] = room_name;
            scr_save_bingo_data();

            if (i == (len - 1))
                scr_add_goal_progress(70, 1);

            exit;
        }
    }
}