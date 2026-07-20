/// PATCH .ignore if CHAPTER_1

#if CHAPTER_2 || CHAPTER_3 || CHAPTER_4
/// REPLACE
            alarm[2] = 1;
/// CODE
            alarm[2] = 10;
#else
/// APPEND
// For some reason they removed this in Chapter 5...
// It handles Alt+Enter fullscreen toggling. In vanilla, it does toggle but doesn't save the setting

if (!global.is_console)
{
    var nowfullscreen = window_get_fullscreen();

    if (nowfullscreen != isfullscreen)
    {
        ini_open("true_config.ini");
        ini_write_real("SCREEN", "FULLSCREEN", nowfullscreen);
        ini_close();

        if (!nowfullscreen)
        {
            window_set_size(640 * window_size_multiplier, 480 * window_size_multiplier);
            alarm[2] = 10;
        }
    }

    isfullscreen = nowfullscreen;
}
#endif
/// END