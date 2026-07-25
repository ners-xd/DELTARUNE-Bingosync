/// PATCH .ignore if CHAPTER_1

/// AFTER
                if (_tensionhealed)
                {
/// CODE
                    used_items[global.charturn] = "item" + string(tempitem[global.bmenucoord[4][global.charturn]][global.charturn]);
/// END

#if CHAPTER_3
/// AFTER
            boardend = 1;
/// CODE
            scr_add_goal_array(7, "chapter3");
/// END
#endif