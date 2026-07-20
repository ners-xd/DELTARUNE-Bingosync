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
        for (var i = 0; i < array_length(used_items); i++)
        {
            if (used_items[i] != "")
            {
                scr_add_goal_array(72, used_items[i]);
                used_items[i] = "";
            }
        }
/// END