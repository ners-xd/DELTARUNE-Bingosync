/// PATCH

/// REPLACE
    if (global.interact == 0 && !(button3_p() && obj_mainchara.threebuffer < 0 && global.flag[7] == 0 && obj_mainchara.battlemode == 0 && obj_mainchara.swordmode == 0))
/// CODE
    if (global.interact == 0 && !(button3_p(false) && obj_mainchara.threebuffer < 0 && global.flag[7] == 0 && obj_mainchara.battlemode == 0 && obj_mainchara.swordmode == 0))
/// END