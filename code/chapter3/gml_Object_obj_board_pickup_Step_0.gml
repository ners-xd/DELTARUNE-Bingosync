/// PATCH

/// REPLACE
                substring = stringsetloc("THE \\cYROUXLS BLOCK\\cW!", "obj_board_pickup_slash_Step_0_gml_272_0");
/// CODE
                {
                    substring = stringsetloc("THE \\cYROUXLS BLOCK\\cW!", "obj_board_pickup_slash_Step_0_gml_272_0");
                    scr_add_goal_array(8, "shop_items", "rouxls");
                }
/// END

/// AFTER
            msgset(0, yougot);
/// CODE
            if (room == room_board_1)
            {
                if (instance_exists(obj_b1susiedig) && obj_b1susiedig.active && point_in_rectangle(obj_mainchara_board.x, obj_mainchara_board.y, 160, 80, 416, 256))
                    scr_add_goal_progress(87, 1);
                else if (instance_exists(obj_b1controls) && obj_b1controls.active && point_in_rectangle(obj_mainchara_board.x, obj_mainchara_board.y, 384, 196, 448, 256))
                    scr_add_goal_progress(118, 1);
            }
/// END