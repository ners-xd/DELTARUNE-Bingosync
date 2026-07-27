/// PATCH

/// REPLACE
if (ds_map_find_value(async_load, "id") == global.savedata_async_id)
/// CODE
var _id = ds_map_find_value(async_load, "id");

if (_id == global.bingo_save_buffer)
{
    if (!ds_map_find_value(async_load, "status"))
        scr_chat_message(c_red, "Couldn't save data to file!");
    else if (scr_is_switch_os())
        switch_save_data_commit();

    buffer_delete(global.bingo_save_buffer);
    global.bingo_save_buffer = -1;
}
else if (_id == global.savedata_async_id)
/// END

/// REPLACE
        else if (scr_is_switch_os())
        {
            switch_save_data_commit();
        }
/// CODE
        else
        {
            if (scr_is_switch_os())
                switch_save_data_commit();

            if (variable_global_exists("wait_for_save"))
            {
                variable_struct_remove(global, "wait_for_save");

                if (room == PLACE_MENU
                #if !CHAPTER_1
                    && !instance_exists(obj_fadeout)
                #endif
                    )
                {
                    snd_free_all();
                    audio_stop_all();
                    room_restart();
                }
            }
        }
/// END