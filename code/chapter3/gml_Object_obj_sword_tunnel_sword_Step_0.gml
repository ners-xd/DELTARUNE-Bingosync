/// PATCH

/// BEFORE
    if (timer >= (11 + c) && timer < (15 + c))
/// CODE
    if (timer == (10 + c))
        global.knight_swords_hit = false;
/// END