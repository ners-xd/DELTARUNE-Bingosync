/// PATCH

/// REPLACE
    if (button2_h() == 1 && SKIPBUFFER < 0 && EVENT <= 75)
/// CODE
    if ((button2_h() == 1 || global.chat_typing || global.starring_goals) && SKIPBUFFER < 0 && EVENT <= 75)
/// END