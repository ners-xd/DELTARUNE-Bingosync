/// PATCH

/// PREPEND
mousex = 0;
mousey = 0;
last_mouse_x = 0;
last_mouse_y = 0;
controller_offset_x = 0;
controller_offset_y = 0;
controller_used = false;
mouse_visible = false;
internet = false;
timestamp_request = -1;
goal_list_request = -1;
srl_list_request = -1;
update_check_request = -1;
newest_mod_version = "";

#if !CHAPTER_1 && !CHAPTER_2 && !CHAPTER_3 && !CHAPTER_4
    isfullscreen = false; // See all_chapters\obj_time_Draw_77
#endif
/// END

#if !CHAPTER_1
/// REPLACE
        alarm[2] = 1;
/// CODE
        alarm[2] = 10;
/// END
#endif