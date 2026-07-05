/// PATCH .ignore if CHAPTER_1 || CHAPTER_2 || CHAPTER_3

/// REPLACE
    if (button3_h())
/// CODE
    if (button3_h(false))
/// END

/// REPLACE
    if (button3_p())
/// CODE
    if (button3_p(false))
/// END

/// REPLACE
        if (i == 8 && button3_h())
/// CODE
        if (i == 8 && button3_h(false))
/// END