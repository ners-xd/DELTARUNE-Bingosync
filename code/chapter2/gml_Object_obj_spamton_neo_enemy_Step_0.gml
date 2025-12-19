/// PATCH

/// AFTER
            scr_wincombat();
/// CODE
            scr_add_goal_progress(43, 1);
/// END

/// AFTER
        if (endtimer == 1)
        {
            snd_free(global.batmusic[0]);
/// CODE
            scr_add_goal_progress(33, 1);
            scr_add_goal_array(110, 1);
/// END