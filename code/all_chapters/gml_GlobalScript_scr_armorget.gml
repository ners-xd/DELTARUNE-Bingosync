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
            scr_add_goal_array(130, "armor" + string(arg0));
            scr_add_goal_buy();

            switch (arg0)
            {
                case 2:
                    scr_add_goal_progress(26, 1);
                    break;

                case 53:
                    scr_add_goal_progress(105, 1);

                case 3:
                case 4:
                case 9:
                case 26:
                case 30:
                case 33:
                    scr_add_goal_array(84, "ribbon" + string(arg0));
                    break;
            }
/// END