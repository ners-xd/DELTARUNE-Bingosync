/// PATCH

/// REPLACE
    else if ((button3_h() == 1 || button1_h() == 1) && cursor_shoottimer > 0 && shooting_enabled == true)
/// CODE
    else if ((button3_h(false) == 1 || button1_h() == 1) && cursor_shoottimer > 0 && shooting_enabled == true)
/// END