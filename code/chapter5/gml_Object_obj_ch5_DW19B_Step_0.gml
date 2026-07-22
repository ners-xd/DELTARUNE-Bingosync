/// PATCH

/// AFTER
    c_snd_play(snd_locker);
    c_customfunc(function(arg0)
    {
/// CODE
        scr_add_goal_progress(46, 1);
/// END

/// BEFORE
    if (global.choice == 0)
    {
/// CODE
        scr_add_goal_progress(37, 1);
/// END