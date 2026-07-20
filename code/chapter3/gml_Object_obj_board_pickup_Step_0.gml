/// PATCH

/// AFTER
            msgset(0, yougot);
/// CODE
            if (type == "key")
            {
                switch (room)
                {
                    case room_board_1:
                        if (instance_exists(obj_b1spring) && obj_b1spring.active)
                            scr_add_goal_array(87, "lancer_key");
                        else if (instance_exists(obj_b1cactusfield2) && obj_b1cactusfield2.active)
                            scr_add_goal_array(87, "cactus_key");
                        else if (instance_exists(obj_b1susiedig) && obj_b1susiedig.active)
                            scr_add_goal_array(87, "bomberman_key");
                        else if (instance_exists(obj_b1controls) && obj_b1controls.active)
                            scr_add_goal_array(87, "quiz_key");
                        else if (instance_exists(obj_b1store) && obj_b1store.active)
                            scr_add_goal_array(87, "shop_key");
                        break;

                    case room_board_2:
                        scr_add_goal_array(87, "board2_key");
                        break;
                }
            }
/// END