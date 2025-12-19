/// IMPORT

if (!obj_time.internet)
{
    scr_chat_message(c_red, "Your internet connection has timed out! Restart the game to attempt a reconnection.");
    instance_destroy();
    exit;
}

http_board = http_get("https://bingosync.com/room/" + global.room_id + "/board");
alarm[0] = 3 * room_speed;