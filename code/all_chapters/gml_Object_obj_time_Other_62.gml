/// IMPORT

try
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
        switch (ds_map_find_value(async_load, "id"))
        {
            case timestamp_request:
                global.start_timestamp = real(ds_map_find_value(async_load, "result"));
                global.start_current_time = current_time;
                break;

            case goal_list_request:
                var info = json_parse(ds_map_find_value(async_load, "result"));
                global.num_goals = array_length(info);
                global.goal_list = array_create(global.num_goals);
                global.goal_progress = array_create(global.num_goals, 0);
                global.goal_custom_vars = [];
                global.goal_indexes = ds_map_create();
                global.goal_vars_indexes = ds_map_create();

                for (var i = 0; i < global.num_goals; i++)
                {
                    global.goal_list[info[i].mod_slot] = 
                    {
                        name: info[i].name,
                        max_progress: 1
                    };

                    if (variable_struct_exists(info[i], "mod_global_var_name"))
                    {
                        var current_index = array_length(global.goal_custom_vars);

                        global.goal_custom_vars[current_index] =
                        {
                            name: info[i].mod_global_var_name,
                            size: info[i].mod_progress_threshold
                        };

                        variable_global_set(info[i].mod_global_var_name, array_create(info[i].mod_progress_threshold, ""));
                        ds_map_add(global.goal_vars_indexes, string_lower(info[i].name), current_index);
                    }
                    else
                    {
                        global.goal_list[info[i].mod_slot].max_progress = info[i].mod_progress_threshold;
                    }

                    ds_map_add(global.goal_indexes, string_lower(info[i].name), info[i].mod_slot);
                }
                break;

            case srl_list_request:
                var info = json_parse(ds_map_find_value(async_load, "result"));
                var len = array_length(info);
                global.srl_goals = array_create(len);

                for (var i = 0; i < len; i++)
                {
                    var inner_len = array_length(info[i]);

                    for (var j = 0; j < inner_len; j++)
                        global.srl_goals[i][j] = string_lower(info[i][j].name);
                }
                break;

            case update_check_request:
                var info = json_parse(ds_map_find_value(async_load, "result"));

                if (real(#GetModVersion()) < real(info.tag_name))
                    newest_mod_version = info.tag_name;
                break;
        }
    }
}
catch (e)
{
}