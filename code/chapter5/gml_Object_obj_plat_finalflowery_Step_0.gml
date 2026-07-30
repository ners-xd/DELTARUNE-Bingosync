/// PATCH

/// REPLACE
            if (button1_p() || button2_p() || button3_p())
/// CODE
            if (button1_p() || button2_p() || button3_p(false))
/// END

/// AFTER
            switch_subcon(3);
        }
/// CODE
        if (qte_prompt_state > 1)
        {
            scr_add_goal_progress(142, 1);
            scr_add_goal_array(111, "flowery");
            scr_add_goal_array(135, "flowery");
        }
/// END