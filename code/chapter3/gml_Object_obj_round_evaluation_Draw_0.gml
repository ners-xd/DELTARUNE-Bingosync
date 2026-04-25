/// PATCH

/// BEFORE
            _col = c_pink;
            
            if (currentphyspoints == physicalchallengepoints)
                _col = 65535;
            
            if (currentphyspoints < 350 && !madesound)
/// CODE
            if (currentphyspoints >= 400 && !madesound)
                scr_add_goal_progress(119, 1);
/// END

/// AFTER
        if (rtimer > 140 && musicstarted == false)
        {
/// CODE
            var desiredletter = lettergrade;

            if (_lettergrade != "")
                desiredletter = _lettergrade; // No idea why there's two variables for this but I'm putting them both just like in the original code, just in case I guess

            if (desiredletter == "Z")
                scr_add_goal_progress(85, 1);
/// END