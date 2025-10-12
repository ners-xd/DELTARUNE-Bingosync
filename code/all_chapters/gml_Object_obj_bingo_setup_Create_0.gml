/// IMPORT

scr_load_bingo_data();
global.ws_client = -1;
global.ws_key = "{}";
global.count_once = false;
#if CHAPTER_1
global.clover_manual = false;
#elsif CHAPTER_2
global.failed_pot_balance = false;
global.teacupshit = false;
#elsif CHAPTER_3
global.knight_hits_type = 0;
global.knight_frame_delay = -1;
#elsif CHAPTER_4
global.forcedswords = false;
global.balthizard_clouds = false;
#endif
global.cookie_sessionid = -1;
httppost = -1;
pos = 0;
max_pos = 16;
sel = -1;
internet = os_is_network_connected();
status_color = internet ? c_lime : c_red;
status_text = internet ? "Internet connection found!" : "Internet connection not found!\nRetrying...";
console_string = -1;
mystring = "";

function censor_password()
{
    var text = "";

    for (var i = 0; i < string_length(global.password); i++)
        text += "*";

    return text;
}