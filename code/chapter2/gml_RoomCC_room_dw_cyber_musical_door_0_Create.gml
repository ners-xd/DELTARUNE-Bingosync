/// PATCH

/// APPEND
else
{
    exception_unhandled_handler(function(e)
    {
        scr_add_goal_progress(58, 1);
        show_message("Congratulations on crashing the game!\nHere's the error if you care:\n\n" + e.longMessage);
        return 0;
    });
}
/// END