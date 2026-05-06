/// PATCH

/// AFTER
            global.keyitem[i] = arg0;
/// CODE
            switch (arg0)
            {
                case 2:
                    scr_add_goal_array(21, "eggs_obtained", "chapter" + string(global.chapter));

                #if CHAPTER_2
                    if (room == room_dw_city_man)
                #endif
                        scr_add_goal_progress(1, 1);
                    break;

                case 13:
                    if (room != PLACE_MENU)
                        scr_add_goal_progress(121, 1);
                    break;
            }
/// END