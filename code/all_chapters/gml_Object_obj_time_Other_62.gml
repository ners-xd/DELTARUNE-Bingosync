/// IMPORT

try
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
        switch (ds_map_find_value(async_load, "id"))
        {
            case goal_list_request:
                var info = json_parse(ds_map_find_value(async_load, "result"));
                global.num_goals = array_length(info);
                global.goal_list = array_create(global.num_goals);
                global.goal_progress = array_create(global.num_goals, 0);

                for (var i = 0; i < global.num_goals; i++)
                {
                    global.goal_list[info[i].mod_slot] = 
                    {
                        name: info[i].name,
                        max_progress: info[i].mod_progress_threshold,
                        array_size: 0
                    };

                    if (variable_struct_exists(info[i], "mod_array_size"))
                    {
                        global.goal_list[info[i].mod_slot].array_size = info[i].mod_array_size;
                        global.goal_progress[info[i].mod_slot] = array_create(info[i].mod_array_size, 0);
                    }
                }

                break;

            case update_check_request:
                var info = json_parse(ds_map_find_value(async_load, "result"));

                if (real(scr_get_mod_version()) < real(info.tag_name))
                    newest_mod_version = info.tag_name;

                break;
        }
    }
}
catch (e)
{
}