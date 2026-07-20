/// PATCH

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

            if (variable_global_exists("wait_for_save") && room == PLACE_MENU)
            {
                variable_struct_remove(global, "wait_for_save");
                snd_free_all();
                audio_stop_all();
                room_restart();
            }
        }
/// END