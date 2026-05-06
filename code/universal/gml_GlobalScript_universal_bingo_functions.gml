/// IMPORT

function scr_get_mod_version()
{
    return "3.00";
}

function vanilla_directory_exists()
{
    if (global.is_console)
        return file_exists("Deltarune/deltarune.sav");
    else
        return directory_exists(game_save_id + "../DELTARUNE/");
}

function vanilla_file_copy(file_name)
{
    if (!global.is_console)
    {
        var vanilla_location = game_save_id + "../DELTARUNE/" + file_name;
        
        if (file_exists(vanilla_location))
            file_copy(vanilla_location, file_name);
    }
}

// Can't nest UMP ifs so this is a bit weird
#if !CHAPTER_SELECT
function scr_get_starting_room()
{
#endif
#if CHAPTER_1
    var possible_rooms = [PLACE_CONTACT, PLACE_MENU, room_legend];
#elsif CHAPTER_2
    var possible_rooms = [room_intro_ch2, room_intro_ch2, room_legend];
#elsif CHAPTER_3
    var possible_rooms = [room_intro, room_intro, room_legend];
#elsif CHAPTER_4
    var possible_rooms = [room_intro_ch4, room_intro_ch4, room_legend];
#endif
#if !CHAPTER_SELECT
    var roomchoice = possible_rooms[0];

    if (scr_completed_chapter_any_slot(global.chapter))
        roomchoice = possible_rooms[2];
    else if (scr_chapter_save_file_exists(global.chapter))
        roomchoice = possible_rooms[1];

    if (roomchoice == room_legend)
        global.tempflag[10] = 1;

    if (global.is_console)
        global.screen_border_alpha = (roomchoice == room_legend);

    return roomchoice;
}
#endif

function scr_import_vanilla_files()
{
    if (!vanilla_directory_exists())
        exit;

    if (global.is_console)
    {
        file_copy("Deltarune/deltarune.sav", "Deltarune/DELTARUNE_bingosync_mod.sav");
        
        if (scr_is_switch_os())
            switch_save_data_commit();
    }
    else
    {
        vanilla_file_copy("dr.ini");
        vanilla_file_copy("true_config.ini");
        
        for (var slot = 0; slot <= 5; slot++)
        {
            vanilla_file_copy("keyconfig_" + string(slot) + ".ini");

            for (var chapter = 1; chapter <= #DR.MaxChapter; chapter++)
                vanilla_file_copy("filech" + string(chapter) + "_" + string(slot));
        }
    }
}

#if !CHAPTER_SELECT
function scr_delete_save_files()
{
    ossafe_ini_open("dr.ini");

    for (var slot = 0; slot <= 2; slot++)
    {
        var keyconfig_file = "keyconfig_" + string(slot) + ".ini";

        if (ossafe_file_exists(keyconfig_file))
            ossafe_file_delete(keyconfig_file);

        for (var chapter = 1; chapter <= #DR.MaxChapter; chapter++)
        {
            var save_file = "filech" + string(chapter) + "_" + string(slot);
            
            if (ossafe_file_exists(save_file))
                ossafe_file_delete(save_file);
            
            var ini = scr_ini_chapter(chapter, slot);
            ini_write_string(ini, "Name", "[EMPTY]");
            ini_write_real(ini, "Level", 0);
            ini_write_real(ini, "Love", 0);
            ini_write_real(ini, "Time", 0);
            ini_write_real(ini, "Room", 0);
            ini_write_real(ini, "Date", 0);
            ini_write_real(ini, "UraBoss", 0);
            ini_write_string(ini, "Version", "0");
            
            if (chapter >= 3)
            {
                ini_write_real(ini, "SideB", 0);
                
                if (chapter == 4)
                    ini_write_real(ini, "Ch4Boss", 0);
            }
        }
    }

    ossafe_ini_close();
    ossafe_savedata_save();
}
#endif