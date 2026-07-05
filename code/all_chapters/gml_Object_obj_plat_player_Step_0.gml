/// PATCH .ignore if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4

/// REPLACE
if (button3_p())
/// CODE
if (button3_p(false))
/// END

/// REPLACE
else if (!button3_h())
/// CODE
else if (!button3_h(false))
/// END