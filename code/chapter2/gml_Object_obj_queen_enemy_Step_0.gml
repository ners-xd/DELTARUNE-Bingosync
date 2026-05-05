/// PATCH

/// AFTER
    snd_free(global.batmusic[0]);
/// CODE
    scr_add_goal_progress(15, 1);
    scr_add_goal_array(135, 2);
/// END

/// BEFORE
                idlesprite = spr_cutscene_25_queen_chair_shocked;
/// CODE
                scr_add_goal_progress(74, 1);
/// END