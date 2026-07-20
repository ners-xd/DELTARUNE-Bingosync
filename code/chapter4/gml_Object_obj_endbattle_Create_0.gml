/// PATCH

/// PREPEND
switch (global.encounterno)
{
    case 183:
        if (global.flag[669] == 1)
            scr_add_goal_progress(90, 1);
        else
            scr_add_goal_progress(91, 1);

        scr_add_goal_array(102, room_get_name(room));
        break;

    case 157:
        scr_add_goal_progress(139, 1);
        break;
}
/// END