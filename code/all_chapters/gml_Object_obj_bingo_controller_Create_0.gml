/// IMPORT

persistent = true;
var timezone = date_get_timezone();
date_set_timezone(timezone_utc);
start_timestamp = date_second_span(date_create_datetime(1970, 1, 2, 0, 0, 0), date_current_datetime());
date_set_timezone(timezone);
board_revealed = false;
http_board = -1;
http_room_settings = -1;
http_feed = -1;
http_room_base = -1;
board_done = false;
room_settings_done = false;
feed_done = false;
room_base_done = false;
console_string = -1;
mystring = "";
update_colors = true;
prev_interact = 0;
mainchara_was_in_prev_room = false;
command_list = "/color or /colour, /star, /autoconnect, /fogofwar, /quit";
money_amount = global.gold;
buy_update_money_amount = global.gold;

#if CHAPTER_3
buy_update_points_amount = global.flag[1044];
#elsif CHAPTER_5
flowery_money_amount = global.flag[1411];
buy_update_flowery_money_amount = global.flag[1411];
#endif

#if CHAPTER_4 || CHAPTER_5
jack_playing = noone;
jack_sfx = [
    snd_your_long, snd_your_long_jp

    #if CHAPTER_4
        , snd_takingtoolongtoolong, snd_taking_too_long_fast, snd_long_only, snd_taking_too_long_small_fast_jp, snd_taking_too_long_small,
        snd_alt_takingtoolong, snd_taking_too_long_small_fast, snd_taking_too_long_small_jp, snd_taking_too_long_jp, snd_taking_too_long_fast_jp,
        snd_long_only_jp, snd_taking_too_long, snd_takingtoolongtoolong_jp, snd_alt_takingtoolong_jp
    #endif
];
jack_sfx_len = array_length(jack_sfx);
#endif

current_str = "";
init_chat_history = [];
chat_history = [];
chat_history_index = -1;
global.goal_name = array_create(25, "");
global.goal_slot = array_create(25, "");
global.goal_colors = array_create(25, "blank");
global.room_seed = -1;
global.room_lockout = "";

exception_unhandled_handler(function(e)
{
    scr_add_goal_progress(58, 1);
    show_message("Congratulations on crashing the game!\nHere's the error if you care:\n\n" + e.longMessage);
    return 0;
});

if (obj_time.internet)
{
    global.ws_client = network_create_socket(network_socket_wss);
    network_connect_raw_async(global.ws_client, "wss://sockets.bingosync.com/broadcast", 443);
    mus_volume(global.currentsong[1], 0, 8);

    with (instance_create(0, 0, obj_fadeout))
        fadespeed = 0.16;
}