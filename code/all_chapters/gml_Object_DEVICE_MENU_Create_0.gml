/// PATCH .ignore if CHAPTER_1

/// REPLACE
var INITMENU = 0;

if (ossafe_file_exists("dr.ini"))
{
    if (FILE[0] == 0 && FILE[1] == 0 && FILE[2] == 0)
    {
        if (COMPLETEFILE_PREV[0] == 1 || COMPLETEFILE_PREV[1] == 1 || COMPLETEFILE_PREV[2] == 1)
            INITMENU = 10;
        
        if (INCOMPLETE_LOAD == 1)
            INITMENU = 10;
    }
}

MENU_NO = INITMENU;
/// CODE
// This is so you don't get sent to the completion data menu when you start the game
// END