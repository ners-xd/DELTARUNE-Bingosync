/// PATCH

/// REPLACE
        game_change("rom:/chapter" + chapstring + "_switch/", parameters);
/// CODE
        game_change("rom:/chapter" + chapstring + "_switch/", "-game game_bingosync.win" + parameters);
/// END

/// REPLACE
                game_change("/chapter" + chapstring + "_windows", "-game data.win" + parameters);
/// CODE
                game_change("/chapter" + chapstring + "_windows", "-game data_bingosync.win" + parameters);
/// END

/// REPLACE
                game_change("", "-game /app0/games/chapter" + chapstring + "_ps4/game.win" + parameters);
/// CODE
                game_change("", "-game /app0/games/chapter" + chapstring + "_ps4/game_bingosync.win" + parameters);
/// END

/// REPLACE
                game_change("", "-game /app0/games/chapter" + chapstring + "_ps5/game.win" + parameters);
/// CODE
                game_change("", "-game /app0/games/chapter" + chapstring + "_ps5/game_bingosync.win" + parameters);
/// END

/// REPLACE
                game_change("chapter" + chapstring + "_mac", parameters);
/// CODE
                game_change("chapter" + chapstring + "_mac", "-game \"" + working_directory + "chapter" + chapstring + "_mac/game_bingosync.ios\"" + parameters);
/// END