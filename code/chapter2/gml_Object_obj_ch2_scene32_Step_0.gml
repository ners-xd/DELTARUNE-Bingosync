/// PATCH

/// BEFORE
        c_talk_wait();
        c_wait(30);
        c_sprite(spr_cutscene_32_toriel_pj_walk_up);
/// CODE
        c_var_instance(id, "end_chapter_goal", true);
/// END

/// APPEND
if (end_chapter_goal && instance_exists(obj_dialoguer) && obj_dialoguer.active && !instance_exists(obj_writer))
{
    end_chapter_goal = false;
    scr_add_goal_progress(13, 1);
}
/// END