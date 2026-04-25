/// PATCH

// "Click" act
/// AFTER
    if (actcon == 5.2 && !instance_exists(obj_poppup_overload))
    {
        with (obj_poppup_enemy)
        {
/// CODE
            scr_add_goal_spares(1);
/// END

/// REPLACE
        if (button3_p() && blockbuffer == 0)
/// CODE
        if (button3_p(false) && blockbuffer == 0)
/// END