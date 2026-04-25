/// PATCH

/// AFTER
snd_play(snd_board_playerhurt);
/// CODE
if (!(instance_exists(obj_b2bombfun) && obj_b2bombfun.active))
    scr_add_hit();
/// END

/// REPLACE
if (switchbuff <= 0 && switchchar == true && controlled && global.interact == 0 && button3_p() && (canfreemove == true || name == "ralsei"))
/// CODE
if (switchbuff <= 0 && switchchar == true && controlled && global.interact == 0 && button3_p(false) && (canfreemove == true || name == "ralsei"))
/// END