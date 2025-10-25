/// PATCH

/// PREPEND
#if CHAPTER_3
global.board_room = "";
#endif
global.show_chat = true;
global.chat_line = array_create(5, "");
global.chat_color = array_create(array_length(global.chat_line), c_white);
global.chat_typing = false;
global.starring_goals = false;
global.starred_goals = array_create(25, false);
global.hit_counter = false;
global.hits = 0;
global.returning_to_title = false;
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