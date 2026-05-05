/// PATCH

/// AFTER
            if (global.monster[star] == 1)
            {
                if (global.monsterstatus[star] == 1)
                {
/// CODE
// This is a workaround for making the regular Tasques count towards the spare/pacify goals in the Tasque Manager fight
#if CHAPTER_2
                    var tasques = 0;

                    if (global.encounterno == 57 && global.monstertype[star] == 42)
                    {
                        with (obj_tasque_enemy)
                            tasques++;
                    }

                    scr_add_goal_spares(1 + tasques, true);
#else
                    scr_add_goal_spares(1, true);
#endif
#if CHAPTER_1
                    if (global.monstertype[star] == 11)
                        scr_add_goal_progress(66, 1);
#endif
/// END

#if CHAPTER_2
/// AFTER
        case 11:
/// CODE
            scr_add_goal_progress(23, 1);
/// END
#endif

/// AFTER
#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3
            if (global.mercymod[star] >= 100)
            {
#else
            else if (global.mercymod[star] >= 100)
            {
#endif
/// CODE
#if CHAPTER_2
                var tasques = 0;

                if (global.encounterno == 57 && global.monstertype[star] == 42)
                {
                    with (obj_tasque_enemy)
                        tasques++;
                }

                scr_add_goal_spares(1 + tasques);
#else
                scr_add_goal_spares(1);
#endif
#if CHAPTER_1
                if (global.monstertype[star] == 11)
                    scr_add_goal_progress(66, 1);
#endif
/// END

#if CHAPTER_1
/// AFTER
        case 204:
/// CODE
            if (global.encounterno == 8 && !global.clover_manual)
                global.clover_manual = true;
/// END
#endif