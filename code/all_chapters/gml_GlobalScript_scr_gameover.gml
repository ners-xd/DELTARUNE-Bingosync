/// PATCH

/// AFTER
#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4
function scr_gameover()
#else
function scr_gameover(arg0 = true)
#endif
{
/// CODE
    scr_add_goal_array(7, "chapter" + string(global.chapter));
/// END