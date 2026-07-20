/// PATCH .ignore if CHAPTER_1

/// REPLACE
    if (button1_p() && __writerkillable == 1)
/// CODE
    if ((button1_p() || scr_bingo_paused()) && __writerkillable == 1)
/// END