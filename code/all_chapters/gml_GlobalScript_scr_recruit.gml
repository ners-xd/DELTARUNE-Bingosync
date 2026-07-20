/// PATCH .ignore if CHAPTER_1

/// REPLACE
            if (global.flag[global.monstertype[myself] + 600] > 1)
                global.flag[global.monstertype[myself] + 600] = 1;
/// CODE
            if (global.flag[global.monstertype[myself] + 600] >= 1)
            {
                global.flag[global.monstertype[myself] + 600] = 1;
                scr_add_goal_array(71, "enemy" + string(global.monstertype[myself]));
                scr_add_goal_array(128, "chapter" + string(global.chapter));

#if CHAPTER_3
                if (global.monstertype[myself] == 55)
                    scr_add_goal_progress(124, 1);
#endif
            }
/// END