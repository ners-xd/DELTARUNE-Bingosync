/// PATCH

#if CHAPTER_1
/// BEFORE
                    scr_itemshift(menuc[11], 0);
                    scr_iteminfo_all();
                    scr_itemcheck(0);
/// CODE
                    if (global.item[menuc[11]] == 3)
                        scr_add_goal_progress(118, 1);
/// END
#else
/// BEFORE
                        scr_itemshift(menuc[11], 0);
                        scr_iteminfo_all();
                        scr_itemcheck(0);
/// CODE
                        if (global.item[menuc[11]] == 3)
                            scr_add_goal_progress(118, 1);
/// END

/// BEFORE
                        global.pocketitem[menuc[11]] = 0;
/// CODE
                        if (global.pocketitem[menuc[11]] == 3)
                            scr_add_goal_progress(118, 1);
/// END
#endif