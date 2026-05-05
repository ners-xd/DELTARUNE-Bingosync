/// PATCH

/// BEFORE
                    }
                }
                else
                {
                    var talked_amount = obj_ch4_LWF03.npc_talked;
                    obj_ch4_LWF03.npc_talked++;
/// CODE
                        scr_add_goal_progress(82, 1);
/// END

/// AFTER
                    obj_ch4_LWF03.npc_talked++;
/// CODE
                    scr_add_goal_progress(82, 1);
/// END

/// AFTER
    if (presents_convo)
    {
/// CODE
        scr_add_goal_progress(120, 1);
/// END