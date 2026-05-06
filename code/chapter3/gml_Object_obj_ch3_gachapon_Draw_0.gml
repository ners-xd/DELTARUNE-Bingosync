/// PATCH

/// REPLACE
                global.flag[prizeflag[selectedPrize]] = 1;
/// CODE
            {
                global.flag[prizeflag[selectedPrize]] = 1;

                if (prizeflag[selectedPrize] >= 1177 && prizeflag[selectedPrize] <= 1181)
                    scr_add_goal_array(106, "gold_items_found", "item" + string(prizeflag[selectedPrize] - 1177));
            }
/// END