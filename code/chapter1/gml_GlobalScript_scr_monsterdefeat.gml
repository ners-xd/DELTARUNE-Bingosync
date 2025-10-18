/// PATCH
// Ponman and Bloxer violence handled separately
// For some reason, specifically these 2 enemies don't call scr_defeatrun

/// AFTER
        global.monster[myself] = 0;
/// CODE
        if ((global.monstertype[myself] == 11 || global.monstertype[myself] == 14) && global.monsterhp[myself] <= 0)
            scr_add_goal_kills(1);
/// END