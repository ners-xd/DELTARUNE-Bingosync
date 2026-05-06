/// PATCH

/// PREPEND
switch (global.encounterno)
{
    case 25:
        scr_add_goal_progress(5, 1);
        scr_add_goal_array(110, "shadow_item_bosses_fought", "jevil");
        scr_add_goal_array(135, "bosses_fought", "jevil");
        break;

    case 40:
        scr_add_goal_progress(12, 1);
        scr_add_goal_array(111, "final_bosses_fought", "king");
        scr_add_goal_array(135, "bosses_fought", "king");
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