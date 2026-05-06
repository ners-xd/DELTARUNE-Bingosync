/// PATCH .ignore if CHAPTER_3

/// AFTER
        con = 18;
/// CODE
        scr_add_goal_array(24, "fix_us_chapters", "chapter" + string(global.chapter));
/// END

#if !CHAPTER_1
/// AFTER
    times_fused++;
/// CODE
    scr_add_goal_progress(20, 1);
/// END
#endif