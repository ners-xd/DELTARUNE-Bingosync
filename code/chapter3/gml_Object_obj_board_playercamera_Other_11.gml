/// PATCH

/// REPLACE
        global.flag[1245]++;
/// CODE
        if (++global.flag[1245] >= 8)
            scr_add_goal_progress(140, 1);
/// END