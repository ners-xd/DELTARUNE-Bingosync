/// PATCH

/// REPLACE
                substring = stringsetloc("THE \\cYROUXLS BLOCK\\cW!", "obj_board_pickup_slash_Step_0_gml_272_0");
/// CODE
                {
                    substring = stringsetloc("THE \\cYROUXLS BLOCK\\cW!", "obj_board_pickup_slash_Step_0_gml_272_0");
                    scr_add_goal_array("shop_items", 1, 8);
                }
/// END

/// AFTER
            msgset(0, yougot);
/// CODE
            if (global.board_room == "b1susiedig" && point_in_rectangle(obj_mainchara_board.x, obj_mainchara_board.y, 160, 80, 416, 256))
                scr_add_goal_progress(87, 1);
            else if (global.board_room == "b1controls" && point_in_rectangle(obj_mainchara_board.x, obj_mainchara_board.y, 384, 196, 448, 256))
                scr_add_goal_progress(118, 1);
/// END