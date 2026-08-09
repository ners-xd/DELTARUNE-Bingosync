/// PATCH

/// REPLACE
    if (button2_h())
/// CODE
    if (button2_h() || scr_bingo_paused())
/// END

/// REPLACE
    if (button2_h() == 1 && SKIPBUFFER < 0 && EVENT <= 75)
/// CODE
    if ((button2_h() == 1 || scr_bingo_paused()) && SKIPBUFFER < 0 && EVENT <= 75)
/// END