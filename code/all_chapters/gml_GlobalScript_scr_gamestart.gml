/// PATCH

#if CHAPTER_3
/// AFTER
function scr_gamestart()
{
/// CODE
    var vars_to_remove = ["elninalosscount", "shadow_mantle_losses", "firstknightbattle", "knight_battle_losses"];

    for (var i = 0; i < array_length(vars_to_remove); i++)
    {
        if (variable_global_exists(vars_to_remove[i]))
            variable_struct_remove(global, vars_to_remove[i]);
    }
/// END
#endif

/// AFTER
    audio_set_master_gain(0, global.flag[17]);
/// CODE
    randomize();

#if CHAPTER_1 || CHAPTER_2
    global.egg_attempts = 0;
#endif

#if CHAPTER_2
    global.mspipis_attempts = 0;
    global.mspipis_encountered = false;
#endif
/// END