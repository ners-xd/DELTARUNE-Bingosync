/// IMPORT

if (global.ws_client != -1)
    network_destroy(global.ws_client);

if (global.is_console)
    ds_map_destroy(global.cookie_sessionid);

ds_map_destroy(global.goal_indexes);
ds_map_destroy(global.goal_vars_indexes);
exception_unhandled_handler(undefined);
instance_destroy();