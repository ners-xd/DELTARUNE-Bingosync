/// PATCH

/// BEFORE
#if CHAPTER_1
if (obj_gamecontroller.gamepad_active == 1)
#else
if (obj_gamecontroller.gamepad_active == 1 && quicksaved != 2)
#endif
/// CODE
if (!global.chat_typing && !global.starring_goals)
{
    if (room != ROOM_INITIALIZE && scr_check_pressed(global.toggle_chat_key, global.toggle_chat_key_gp))
    {
        global.show_chat = !global.show_chat;
        scr_save_bingo_data();
    }
/// END

/// BEFORE
#if CHAPTER_1
if (border_fade_out)
#else
    }
}

if (scr_debug())
#endif
/// CODE
}
/// END