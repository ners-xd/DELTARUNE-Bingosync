/// PATCH .ignore if CHAPTER_1

/// PREPEND
global.autoconnect = false;

if (file_exists(#GetBingoFile()))
{
    var file = file_text_open_read(#GetBingoFile());
    var json = json_parse(file_text_read_string(file));
    file_text_close(file);

    if (variable_struct_exists(json, "preferences") && variable_struct_exists(json.preferences, "autoconnect"))
        global.autoconnect = json.preferences.autoconnect;
}
/// END