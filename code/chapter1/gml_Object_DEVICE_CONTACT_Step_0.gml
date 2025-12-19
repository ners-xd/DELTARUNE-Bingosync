/// PATCH

/// REPLACE
            game_restart();
        }
    }
    else
    {
        EVENT = 68;
/// CODE
            game_restart_true();
        }
    }
    else
    {
        EVENT = 68;
/// END

/// REPLACE
            game_restart();
        }
    }
    else
    {
        EVENT = 72;
/// CODE
            game_restart_true();
        }
    }
    else
    {
        EVENT = 72;
/// END

/// REPLACE
    if (button2_h() == 1 && SKIPBUFFER < 0 && EVENT <= 75)
/// CODE
    if ((button2_h() == 1 || global.chat_typing || global.starring_goals) && SKIPBUFFER < 0 && EVENT <= 75)
/// END