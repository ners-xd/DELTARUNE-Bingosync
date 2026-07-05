/// PATCH

/// AFTER
            global.flag[1312] += itemidchest;
/// CODE
            scr_add_goal_pink_coin();
/// END

/// REPLACE
        if (noroom == 0)
            global.flag[itemflag] = 1;
/// CODE
        if (noroom == 0)
        {
            global.flag[itemflag] = 1;

            if (itemflag == 1831)
                scr_add_goal_progress(161, 1);
        }
/// END