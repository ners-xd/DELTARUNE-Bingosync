/// PATCH

#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4
/// BEFORE
scr_damage_cache();
/// CODE
scr_add_hit();
/// END
#else
/// AFTER
    if (global.inv < 0)
    {
/// CODE
        scr_add_hit();
/// END
#endif