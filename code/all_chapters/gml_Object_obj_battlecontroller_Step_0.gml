/// PATCH

#if !CHAPTER_1
/// AFTER
                if (_tensionhealed)
                {
/// CODE
                    used_items[global.charturn] = "item" + string(tempitem[global.bmenucoord[4][global.charturn]][global.charturn]);
/// END
#endif

/// AFTER
        reset = 1;
/// CODE
        if (!global.grazed_at_all)
            scr_add_goal_progress(133, 1);
        else
            global.grazed_at_all = false;
/// END