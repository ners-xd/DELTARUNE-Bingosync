/// PATCH

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

#if CHAPTER_3
/// AFTER
obj_tenna_enemy.minigamefailcount++;
/// CODE
global.hits[global.chapter - 1]--;
save_fld_ini();
/// END

#elsif CHAPTER_4
/// BEFORE
scr_damage_cache();
/// CODE
if (instance_exists(obj_ch4_DCA01) && global.interact == 0)
{
    global.hits[global.chapter - 1]--;
    save_fld_ini();
}
/// END
#endif