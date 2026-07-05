/// PATCH

/// BEFORE
            for (i = 0; i < 3; i += 1)
/// CODE
            scr_add_goal_progress(79, 1);
/// END

#if !CHAPTER_1 && !CHAPTER_2 && !CHAPTER_3 && !CHAPTER_4
/// BEFORE
            global.spelldelay = 64 + (_scythecount * 10);
/// CODE
            scr_add_goal_spares(_successcount, true);
/// END
#endif