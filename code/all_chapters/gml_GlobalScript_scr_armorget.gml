/// PATCH

/// AFTER
#if CHAPTER_1
        if (global.armor[i] == 0)
        {
#else
        else
        {
#endif
/// CODE
            scr_add_goal_array(130, arg0);

            switch (arg0)
            {
                case 2:
                    scr_add_goal_progress(26, 1);
                    break;

                case 54:
                    scr_add_goal_progress(108, 1);
                    break;

                case 53:
                    scr_add_goal_progress(105, 1);
                    break;
            }
/// END