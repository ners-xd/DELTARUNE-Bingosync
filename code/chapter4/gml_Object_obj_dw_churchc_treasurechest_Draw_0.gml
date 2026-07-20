/// PATCH

/// AFTER
if (con == 1)
{
/// CODE
    if (!saw_friend && obj_mainchara.x > 720)
    {
        with (obj_fancy_ripples_alt)
        {
            if (array_length(ripples) > 0)
            {
                scr_add_goal_array(154, "chapter4-churchc");
                obj_dw_churchc_treasurechest.saw_friend = true;
                break;
            }
        }
    }
/// END