/// PATCH

/// PREPEND
if (global.encounterno == 183)
{
    if (global.flag[669] == 1)
        scr_add_goal_progress(90, 1);
    else
        scr_add_goal_progress(91, 1);

    scr_add_goal_array(102, "golden_sheets_found", room_get_name(room));
}
/// END