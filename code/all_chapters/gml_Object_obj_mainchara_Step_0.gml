/// PATCH

#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4
/// REPLACE
    if (button3_p() && threebuffer < 0)
/// CODE
    if (button3_p(false) && threebuffer < 0)
/// END
#else
/// REPLACE
    if (button3_p() && threebuffer < 0 && !instance_exists(obj_climb_kris))
/// CODE
    if (button3_p(false) && threebuffer < 0 && !instance_exists(obj_climb_kris))
/// END
#endif