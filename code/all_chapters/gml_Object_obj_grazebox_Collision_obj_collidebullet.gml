/// PATCH

/// BEFORE
        if (grazed == 1)
/// CODE
        if (!global.grazed_at_all)
            global.grazed_at_all = true;
/// END