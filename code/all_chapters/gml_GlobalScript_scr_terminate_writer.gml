/// PATCH .ignore if CHAPTER_1

/// REPLACE
    if (button1_p() && __writerkillable == 1)
/// CODE
    if ((button1_p() || global.chat_typing || global.starring_goals) && __writerkillable == 1)
/// END