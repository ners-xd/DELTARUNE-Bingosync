/// PATCH

/// AFTER
snd_play(snd_board_playerhurt);
/// CODE
if (!(instance_exists(obj_b2bombfun) && obj_b2bombfun.active))
    scr_add_hit();
/// END