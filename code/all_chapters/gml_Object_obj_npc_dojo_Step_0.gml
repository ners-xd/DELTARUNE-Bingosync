/// PATCH .ignore if CHAPTER_1 || CHAPTER_3

/// AFTER
    if (global.flag[36] == 0)
    {
/// CODE
        scr_add_goal_array(32, "dojo_challenges_done", "challenge" + string(dojoFlag - 810));

        if (dojoFlag == 815)
            scr_add_goal_progress(129, 1);
/// END