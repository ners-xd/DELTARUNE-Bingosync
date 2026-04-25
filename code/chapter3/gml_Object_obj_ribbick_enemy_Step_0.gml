/// PATCH

/// REPLACE
        if (button3_p() == 1)
/// CODE
        if (button3_p(false) == 1)
/// END

/// REPLACE
        if (button3_p() == 1 && presscount < 5)
/// CODE
        if (button3_p(false) == 1 && presscount < 5)
/// END

/// AFTER
                if (other.CroakOnX == true || other.id == id)
                {
/// CODE
                    scr_add_goal_spares(1);
/// END