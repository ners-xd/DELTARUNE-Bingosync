/// PATCH

/// AFTER
            global.keyitem[i] = arg0;
/// CODE
            scr_add_goal_buy();

            switch (arg0)
            {
                case 2:
                    scr_add_goal_array(21, "chapter" + string(global.chapter));

                #if CHAPTER_2
                    if (room == room_dw_city_man)
                #endif
                        scr_add_goal_progress(1, 1);
                    break;

            #if CHAPTER_3
                case 18:
                    scr_add_goal_progress(91, 1);
                    break;
            #endif

                case 13:
                    if (room != PLACE_MENU)
                        scr_add_goal_progress(121, 1);
                    break;

            #if CHAPTER_5
                case 20:
                case 21:
                case 22:
                case 23:
                case 26:
                case 27:
                case 28:
                    if (global.flag[1454] < 70 && scr_keyitemcheck(20) && scr_keyitemcheck(21) && scr_keyitemcheck(22) && scr_keyitemcheck(23) && scr_keyitemcheck(26) && scr_keyitemcheck(27) && scr_keyitemcheck(28))
                        scr_add_goal_progress(149, 1);
                    break;
            #endif

                case 24:
                case 33:
                    scr_add_goal_progress(160, 1);
                    break;
            }
/// END