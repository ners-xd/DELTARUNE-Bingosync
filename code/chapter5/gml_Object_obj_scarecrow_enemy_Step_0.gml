/// PATCH
// Shi violence is handled separately
// for some reason

/// AFTER
            scr_monsterdefeat();
/// CODE
            scr_add_goal_kills(1);
/// END

/// AFTER
                if (global.flag[global.monstertype[myself] + 600] != -1)
                {
/// CODE
                    if (global.flag[672] == 1)
                        scr_add_goal_array(69, "enemy72");
/// END