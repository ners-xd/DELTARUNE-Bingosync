/// PATCH

/// AFTER
        global.gold += global.monstergold[3];
/// CODE
        scr_add_goal_money(global.monstergold[3]);
/// END

/// BEFORE
        if (noreturn == 0)
/// CODE
        if (!global.grazed_at_all)
            scr_add_goal_progress(133, 1);
        else
            global.grazed_at_all = false;
/// END