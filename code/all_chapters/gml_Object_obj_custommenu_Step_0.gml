/// PATCH .ignore if CHAPTER_1

/// REPLACE
if (button3_p() && buffer1 <= 0 && buffer2 <= 0 && buffer3 <= 0)
/// CODE
if (button3_p(false) && buffer1 <= 0 && buffer2 <= 0 && buffer3 <= 0)
/// END