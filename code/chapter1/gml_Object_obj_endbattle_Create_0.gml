/// PATCH

/// PREPEND
switch (global.encounterno)
{
    case 25:
        scr_add_goal_progress(5, 1);
        scr_add_goal_array(110, "jevil");
        scr_add_goal_array(135, "jevil");
        break;

    case 40:
        scr_add_goal_progress(12, 1);
        scr_add_goal_array(111, "king");
        scr_add_goal_array(135, "king");
        break;

    case 8:
        if (!global.clover_manual)
            scr_add_goal_progress(60, 1);
        else
            global.clover_manual = false;
        break;

    case 3:
        scr_add_goal_progress(63, 1);
        break;

    case 32:
        scr_add_goal_progress(67, 1);
        break;
}
/// END