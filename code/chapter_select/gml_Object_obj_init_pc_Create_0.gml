/// PATCH

/// REPLACE
            alarm[0] = 1;
/// CODE
            if (!variable_global_exists("first_launch"))
            {
                global.first_launch = true;
                alarm[0] = 10;
            }
            else
            {
                alarm[0] = 1;
            }
/// END