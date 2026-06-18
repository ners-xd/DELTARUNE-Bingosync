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
global.goal_name = array_create(25, "");
global.goal_slot = array_create(25, "");
global.goal_colors = array_create(25, "blank");
global.room_seed = -1;
global.room_lockout = "";

if (obj_time.internet)
{
    global.ws_client = network_create_socket(network_socket_wss);
    network_connect_raw_async(global.ws_client, "wss://sockets.bingosync.com/broadcast", 443);
    mus_volume(global.currentsong[1], 0, 8);

    with (instance_create(0, 0, obj_fadeout))
        fadespeed = 0.16;
}