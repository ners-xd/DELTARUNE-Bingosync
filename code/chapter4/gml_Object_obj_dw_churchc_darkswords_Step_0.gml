/// PATCH

/// AFTER
        if (cutscene == 0 && kris.x > darkness_midx)
        {
/// CODE
            global.forcedswords = true;
/// END

/// BEFORE
            mus_initloop("dark_place.ogg");
/// CODE
            global.forcedswords = false;
/// END

/// AFTER
            snd_volume(wind_sound, 0, 130);
/// CODE
            global.forcedswords = false;
/// END