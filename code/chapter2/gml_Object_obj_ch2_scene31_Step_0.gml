/// PATCH

/// BEFORE
    c_soundplay(snd_break1);
/// CODE
    c_var_instance(id, "soul_goal", true);
/// END

/// APPEND
if (soul_goal)
{
    soul_goal = false;
    scr_add_goal_progress(162, 1);
}
/// END