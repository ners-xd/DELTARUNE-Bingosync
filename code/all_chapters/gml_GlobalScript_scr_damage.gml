/// PATCH

#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4
/// REPLACE
function scr_damage()
/// CODE
function scr_damage(singletarget = true)
/// END

/// BEFORE
scr_damage_cache();
/// CODE
if (singletarget)
    scr_add_hit();
/// END
#else
/// REPLACE
function scr_damage(arg0 = true)
/// CODE
function scr_damage(singletarget = true, diff_tdamage = true)
/// END

/// AFTER
    if (global.inv < 0)
    {
/// CODE
        if (singletarget)
            scr_add_hit();
/// END

/// REPLACE
        if (!arg0)
/// CODE
        if (!diff_tdamage)
/// END
#endif

#if CHAPTER_4
/// BEFORE
scr_damage_cache();
/// CODE
if (instance_exists(obj_ch4_DCA01) && global.interact == 0)
{
    global.hits--;
    scr_save_bingo_data();
}
/// END
#endif