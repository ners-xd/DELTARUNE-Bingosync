/// IMPORT

global.autoconnect = false;

if (file_exists(#GetBingoFile()))
{
    var file = file_text_open_read(#GetBingoFile());
    var json = json_parse(file_text_read_string(file));
    file_text_close(file);

    if (variable_struct_exists(json, "preferences") && variable_struct_exists(json.preferences, "autoconnect"))
        global.autoconnect = json.preferences.autoconnect;
}

texturepagecount = 0;
prog = 0;
loaded = false;
pages = [];

if (!variable_global_exists("prefetchtexload"))
{
    global.prefetchtexload = false;
}
else if (global.prefetchtexload == true)
{
    loaded = true;
    visible = false;
}

texture_groups = ["Default", "ConsolePS4"];

if (global.is_console)
{
    if (scr_is_switch_os())
        texture_groups = ["Default", "ConsoleSwitch"];

    array_push(texture_groups, "Console");
}

var i = 0;
var j = 0;
var _tex_array = [];

for (i = 0; i < array_length(texture_groups); i++)
{
    _tex_array = texturegroup_get_textures(texture_groups[i]);

    for (j = 0; j < array_length(_tex_array); j++)
    {
        texturepagecount++;
        array_push(pages, _tex_array[j]);
    }
}