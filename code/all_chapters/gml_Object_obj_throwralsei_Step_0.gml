/// PATCH

/// REPLACE
    if (button3_p() && throwalpha >= 0.9 && throwready == 1)
/// CODE
    if (button3_p(false) && throwalpha >= 0.9 && throwready == 1)
/// END

/// REPLACE
    if (button3_p() && throwready == 0)
/// CODE
    if (button3_p(false) && throwready == 0)
/// END