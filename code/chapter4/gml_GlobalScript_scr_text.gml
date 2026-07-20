/// PATCH

/// AFTER
                var can_afford = global.lgold >= 5;
                
                if (can_afford)
                {
/// CODE
                    scr_add_goal_array(8, room_get_name(room));
/// END

/// AFTER
                    cute_active = true;
/// CODE
                scr_add_goal_progress(132, 1);
/// END