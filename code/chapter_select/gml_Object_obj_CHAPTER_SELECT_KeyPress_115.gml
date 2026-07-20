/// IMPORT
// For some reason toggling fullscreen with F4 isn't a thing in vanilla Chapter Select

if (variable_global_exists("is_console") && !global.is_console)
    window_set_fullscreen(!window_get_fullscreen());