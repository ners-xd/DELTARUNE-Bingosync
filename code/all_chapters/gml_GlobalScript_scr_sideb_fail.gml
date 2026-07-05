/// PATCH .ignore if CHAPTER_1 || CHAPTER_3 || CHAPTER_5

/// BEFORE
        global.flag[916] = 1;
/// CODE
        if (global.flag[915] >= 3)
            scr_add_goal_progress(41, 1);
/// END