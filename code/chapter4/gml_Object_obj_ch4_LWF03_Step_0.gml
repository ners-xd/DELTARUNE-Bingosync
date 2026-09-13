/// PATCH

/// AFTER
if (con == 3 && !i_ex(obj_cutscene_master))
{
/// CODE
    scr_add_goal_progress(82, 1);
/// END

/// AFTER
            upstairs_con = 1;
/// CODE
            scr_add_goal_progress(13, 1);
/// END

/// BEFORE
        scr_complete_save_file();
/// CODE
        scr_add_goal_progress(162, 1);
/// END