/// PATCH

/// AFTER
#if CHAPTER_1
function scr_endturn()
{
/// CODE
    with (obj_battlecontroller)
#else
    with (obj_battlecontroller)
    {
/// CODE
#endif
        if (used_item_count > 0)
        {
            scr_add_goal_progress(72, used_item_count);
            used_item_count = 0;
        }
/// END