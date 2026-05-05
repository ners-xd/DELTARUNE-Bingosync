/// PATCH

/// PREPEND
create_bingo_start_screen = function()
{
    stop_bgm();
    vanilla_file_copy("bingo_data.json");

    var start_screen = instance_create(0, 0, obj_screen_start);
    start_screen._font = fnt_main;
    start_screen._text_prompt_y_pos = 16;
    start_screen._line_height = 16;
    start_screen.init(id,
        "Bingosync Mod save data is stored in a\ndifferent place. Would you like\nto import your vanilla DELTARUNE data?\n\nThis will only be asked once, but you can\ncome back to this in the mod's settings menu.",
        [
            new create_choice("Yes", 1001),
            new create_choice("No", 1002)
        ],
        0);

    with (obj_ui_choice)
        _font = fnt_main;
 
    start_screen.fade_in();
};
/// END

/// AFTER
init = function()
{
/// CODE
    if (vanilla_directory_exists() && !ossafe_file_exists("true_config.ini"))
    {
        change_state(1000);
        exit;
    }
/// END

/// AFTER
    _current_state = arg0;
    
    switch (_current_state)
    {
/// CODE
        case 1000:
            create_bingo_start_screen();
            break;
/// END

/// AFTER
    var event_name = arg0;
    var event_value = arg1;
    
    switch (_current_state)
    {
/// CODE
        case 1000:
            if (event_value == 1001)
                scr_import_vanilla_files();

            if (global.is_console)
            {
                _restart_room = true;
            }
            else
            {
                ini_open("true_config.ini");
                ini_write_real("BINGOSYNC_MOD", "START_SCREEN_CLOSED", true);
                ini_close("true_config.ini");
                room_restart();
            }
            break;
/// END

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