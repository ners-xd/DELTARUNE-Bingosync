/// PATCH

#if CHAPTER_1
/// AFTER
            global.item[i] = arg0;
/// CODE
            scr_add_goal_array(155, "consumables_obtained", "consumable" + string(arg0));
            scr_add_goal_buy();

            if (i == 11)
            {
                scr_add_goal_progress(39, 1);
            }
            else
            {
                switch (arg0)
                {
                    case 2:
                        scr_add_goal_array(36, "revivemints_obtained", room_get_name(room));
                        break;

                    case 7:
                        scr_add_goal_progress(19, 1);
                        break;

                    case 9:
                        scr_add_goal_progress(47, 1);
                        break;
                }
            }
#else
/// AFTER
            global.item[__i] = arg0;
/// CODE
            if (__i == 11)
                scr_add_goal_progress(39, 1);
/// END

/// BEFORE
    script_execute(scr_iteminfo_all);
/// CODE
    if (!noroom)
    {
        scr_add_goal_array(155, "consumables_obtained", "consumable" + string(arg0));
        scr_add_goal_buy();

        switch (arg0)
        {
            case 2:
                if (!global.fighting)
                    scr_add_goal_array(36, "revivemints_obtained", room_get_name(room));
                break;

            case 30:
                scr_add_goal_progress(56, 1);
                break;

            case 35:
                scr_add_goal_progress(89, 1);
                break;

            case 65:
                scr_add_goal_progress(108, 1);
                break;

            case 63:
                scr_add_goal_progress(109, 1);
                break;

            case 33:
                scr_add_goal_progress(122, 1);
                break;
        }
    }
#endif
/// END