/// PATCH

/// AFTER
                with (obj_ch2_scene21_loop)
                    photocon = 2;
/// CODE
                scr_add_goal_progress(64, 1);
/// END

/// REPLACE
                    global.gold -= 100;
/// CODE

/// END

/// BEFORE
            snd_play(snd_equip);
            msgsetloc(0, "* Okay^1, here you go!/", "scr_text_slash_scr_text_gml_4617_0");
/// CODE
            global.gold -= 100;
/// END

/// BEFORE
                        global.gold -= 1997;
/// CODE
                        scr_add_goal_progress(29, 1);
/// END