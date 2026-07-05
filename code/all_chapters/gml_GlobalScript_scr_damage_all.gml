/// PATCH

/// BEFORE
#if CHAPTER_1 || CHAPTER_2
scr_damage_cache();
#else
remdamage = damage;
#endif
/// CODE
scr_add_hit();
/// END

#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4
/// REPLACE
scr_damage();
/// CODE
scr_damage(false);
/// END
#else
/// REPLACE
scr_damage(arg1);
/// CODE
scr_damage(false, arg1);
/// END
#endif