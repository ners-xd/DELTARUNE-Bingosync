/// PATCH

/// PREPEND
#if CHAPTER_3
var vars_to_remove = ["elninalosscount", "shadow_mantle_losses", "firstknightbattle", "knight_battle_losses"];

for (var i = 0; i < array_length(vars_to_remove); i++)
{
    if (variable_global_exists(vars_to_remove[i]))
        variable_struct_remove(global, vars_to_remove[i]);
}
#endif

global.show_chat = true;
global.chat_line = array_create(5, "");
global.chat_color = array_create(array_length(global.chat_line), c_white);
global.chat_typing = false;
global.starring_goals = false;
global.starred_goals = array_create(25, false);
/// END

#if CHAPTER_1 || CHAPTER_2
/// REPLACE
    scr_prefetch_textures();
    scr_load_audio();
/// CODE
    scr_load_audio(); // Avoid prefetching textures twice
/// END
#endif

#if CHAPTER_1
/// APPEND
#else
/// REPLACE
loadtex = -4;

if (global.is_console)
    loadtex = instance_create(0, 0, obj_prefetchtex);
else
    scr_prefetch_textures();
/// CODE
#endif
loadtex = instance_create(0, 0, obj_prefetchtex);
/// END