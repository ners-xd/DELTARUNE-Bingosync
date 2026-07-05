/// PATCH .ignore if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4

/// AFTER
function scr_damage_all_platmode()
{
    if (global.inv < 0)
    {
/// CODE
        scr_add_hit();
/// END