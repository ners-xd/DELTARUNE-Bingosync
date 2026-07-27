/// PATCH

/// PREPEND
global.show_chat = true;
global.chat_line = array_create(5, "");
global.chat_color = array_create(array_length(global.chat_line), c_white);
global.chat_typing = false;
global.starring_goals = false;
global.starred_goals = array_create(25, false);
global.bingo_save_buffer = -1;

global.start_current_time = current_time;
var timezone = date_get_timezone();
date_set_timezone(timezone_utc);
global.start_timestamp = ((date_second_span(date_create_datetime(1970, 1, 2, 0, 0, 0), date_current_datetime()) + 86400) * 1000) - global.start_current_time;
date_set_timezone(timezone);
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