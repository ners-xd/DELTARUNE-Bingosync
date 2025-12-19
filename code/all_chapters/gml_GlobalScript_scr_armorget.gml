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

                case 4:
                    scr_add_goal_array(114, 0);
                    break;

                case 3:
                    scr_add_goal_array(114, 1);
                    break;

                case 26:
                    scr_add_goal_array(114, 2);
                    break;

                case 53:
                    scr_add_goal_progress(105, 1);
                    scr_add_goal_array(114, 3);
                    break;
            }
/// END