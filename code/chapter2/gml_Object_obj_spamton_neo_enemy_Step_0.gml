/// PATCH

/// AFTER
            scr_wincombat();
/// CODE
            scr_add_goal_progress(43, 1);
            scr_add_goal_array(110, "spamton_neo");
            scr_add_goal_array(111, "spamton_neo");
            scr_add_goal_array(135, "spamton_neo");
/// END

/// AFTER
        if (endtimer == 1)
        {
            snd_free(global.batmusic[0]);
/// CODE
            scr_add_goal_progress(33, 1);
            scr_add_goal_array(110, "spamton_neo");
            scr_add_goal_array(135, "spamton_neo");
/// END