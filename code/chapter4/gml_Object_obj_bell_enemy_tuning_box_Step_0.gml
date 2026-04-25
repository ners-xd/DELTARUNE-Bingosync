/// PATCH

/// REPLACE
if ((button1_p() || button2_p() || button3_p() || automiss == true) && bar_x >= 70 && con == 0 && image_alpha >= 0.6)
/// CODE
if ((button1_p() || button2_p() || button3_p(false) || automiss == true) && bar_x >= 70 && con == 0 && image_alpha >= 0.6)
/// END