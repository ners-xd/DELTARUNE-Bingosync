/// PATCH

/// REPLACE
function button3_h()
{
/// CODE
function button3_h(extra_checks = true)
{
    if (extra_checks && (global.chat_typing || global.starring_goals))
        return true;
/// END