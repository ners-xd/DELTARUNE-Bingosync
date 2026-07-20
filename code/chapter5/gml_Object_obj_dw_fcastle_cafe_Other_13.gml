/// PATCH

/// AFTER
        cutscene = 1001;
/// CODE
        var flowers_to_count = [];

        if (string_pos(nameAqua, menuOptions[mpos].desc) > 0)
            array_push(flowers_to_count, "aqua");

        if (string_pos(nameSeth, menuOptions[mpos].desc) > 0)
            array_push(flowers_to_count, "seth");

        if (string_pos(nameYellow, menuOptions[mpos].desc) > 0)
            array_push(flowers_to_count, "yellow");

        if (string_pos(nameGreen, menuOptions[mpos].desc) > 0)
            array_push(flowers_to_count, "green");

        if (string_pos(nameBlue, menuOptions[mpos].desc) > 0)
            array_push(flowers_to_count, "blue");

        if (string_pos(nameOrange, menuOptions[mpos].desc) > 0)
            array_push(flowers_to_count, "orange");

        for (var i = 0; i < array_length(flowers_to_count); i++)
            scr_add_goal_array(152, flowers_to_count[i]);
/// END