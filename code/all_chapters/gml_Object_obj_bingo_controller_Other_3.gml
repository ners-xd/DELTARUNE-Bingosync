/// IMPORT

if (global.ws_client != -1)
    network_destroy(global.ws_client);

if (global.is_console)
    ds_map_destroy(global.cookie_sessionid);

ds_list_destroy(global.recruits_list);
instance_destroy();