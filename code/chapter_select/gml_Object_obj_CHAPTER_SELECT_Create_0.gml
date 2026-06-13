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
    if (vanilla_directory_exists() && !file_exists("bingosync_mod_first_launch"))
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

            if (variable_global_exists("first_launch"))
                variable_struct_remove(global, "first_launch");

            var file = file_text_open_write("bingosync_mod_first_launch");
            file_text_write_string(file, "The existence of this file makes the Chapter Select save import prompt not appear.");
            file_text_close(file);

            if (scr_is_switch_os())
                switch_save_data_commit();

            room_restart();
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