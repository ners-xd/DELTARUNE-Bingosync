/// PATCH

/// REPLACE
    if (global.flag[1524] <= 182 && global.flag[1524] != 0 && global.flag[1525] <= 302 && global.flag[1525] != 0)
/// CODE
    if (global.flag[1524] <= 188 && global.flag[1524] != 0 && global.flag[1525] <= 308 && global.flag[1525] != 0)
/// END

/// AFTER
    x = (xstart + room_width) - (won * room_width);
    
    if (myinteract == 3)
    {
/// CODE
        scr_add_goal_progress(140, 1);
/// END