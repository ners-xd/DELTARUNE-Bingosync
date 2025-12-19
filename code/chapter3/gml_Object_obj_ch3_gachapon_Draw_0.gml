/// PATCH

/// REPLACE
                global.flag[prizeflag[selectedPrize]] = 1;
/// CODE
            {
                global.flag[prizeflag[selectedPrize]] = 1;

                if (prizeflag[selectedPrize] >= 1177 && prizeflag[selectedPrize] <= 1181)
                    scr_add_goal_array(106, prizeflag[selectedPrize] - 1177);
            }
/// END