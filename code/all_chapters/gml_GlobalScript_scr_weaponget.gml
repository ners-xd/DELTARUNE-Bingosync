/// PATCH

/// AFTER
#if CHAPTER_1
        if (global.weapon[i] == 0)
        {
#else
        else
        {
#endif
/// CODE
            scr_add_goal_array(131, "weapon" + string(arg0));
            scr_add_goal_buy();

            if (arg0 == 31)
                scr_add_goal_progress(158, 1);
/// END