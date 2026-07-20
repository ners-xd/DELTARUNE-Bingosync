/// PATCH

/// REPLACE
function button3_p()
{
/// CODE
function button3_p(extra_checks = true)
{
    if (extra_checks && scr_bingo_paused())
        return true;
/// END