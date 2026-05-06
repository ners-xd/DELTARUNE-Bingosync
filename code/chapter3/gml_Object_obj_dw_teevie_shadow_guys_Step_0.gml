/// PATCH

/// REPLACE
                global.flag[654] += 0.04;
                
                if (global.flag[654] > 1)
                    global.flag[654] = 1;
/// CODE
                global.flag[654] += 0.04;

                if (global.flag[654] >= 1)
                {
                    global.flag[654] = 1;
                    scr_add_goal_array(71, "enemies_recruited", "enemy54");
                    scr_add_goal_array(128, "recruit_chapters", "chapter3");
                }
/// END

/// REPLACE
        global.flag[654] += 0.4;
        
        if (global.flag[654] > 1)
            global.flag[654] = 1;
/// CODE
        global.flag[654] += 0.4;

        if (global.flag[654] >= 1)
        {
            global.flag[654] = 1;
            scr_add_goal_array(71, "enemies_recruited", "enemy54");
            scr_add_goal_array(128, "recruit_chapters", "chapter3");
        }
/// END

/// REPLACE
    if (timer == 45)
    {
        global.flag[654] += 0.04;
        
        if (global.flag[654] > 1)
            global.flag[654] = 1;
/// CODE
    if (timer == 45)
    {
        global.flag[654] += 0.04;

        if (global.flag[654] >= 1)
        {
            global.flag[654] = 1;
            scr_add_goal_array(71, "enemies_recruited", "enemy54");
            scr_add_goal_array(128, "recruit_chapters", "chapter3");
        }
/// END