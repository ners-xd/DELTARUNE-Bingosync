/// IMPORT

persistent = true;
board_connected = false;
board_revealed = false;
http_board = -1;
http_room_settings = -1;
http_feed = -1;
console_string = -1;
mystring = "";
update_colors = true;
prev_interact = 0;
mainchara_was_in_prev_room = false;
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
}