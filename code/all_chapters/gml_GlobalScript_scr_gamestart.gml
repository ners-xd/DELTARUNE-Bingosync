/// PATCH

/// AFTER
    audio_set_master_gain(0, global.flag[17]);
/// CODE
    randomize();

#if CHAPTER_1 || CHAPTER_2
    global.egg_attempts = 0;
#endif

#if CHAPTER_2
    global.mspipis_attempts = 0;
    global.mspipis_encountered = false;
#endif
/// END