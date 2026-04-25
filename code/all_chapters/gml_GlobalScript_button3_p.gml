/// PATCH

/// REPLACE
function button3_p()
{
/// CODE
function button3_p(extra_checks = true)
{
    if (extra_checks && (global.chat_typing || global.starring_goals))
        return true;
/// END