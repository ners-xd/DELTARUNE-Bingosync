/// PATCH

/// AFTER
    else
    {
/// CODE
        if (scr_sideb_get_phase() == 0 && global.flag[917] < 2 && global.flag[918] == 0)
            global.egg_attempts++;
/// END

/// AFTER
if (room == room_dw_city_man)
{
/// CODE
    global.egg_attempts = 0;
/// END