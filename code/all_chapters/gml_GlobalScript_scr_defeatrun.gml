/// PATCH

#if !CHAPTER_1
/// AFTER
function scr_defeatrun()
{
/// CODE
    var is_recruited = false;
/// END

/// AFTER
    if (object_is_ancestor(object_index, obj_monsterparent))
    {
/// CODE
        is_recruited = (global.flag[global.monstertype[myself] + 600] == 1);
/// END
#endif

#if CHAPTER_4
/// AFTER
            global.flag[1598]++;
/// CODE
            scr_add_goal_progress(115, 1);
/// END
#endif

#if !CHAPTER_1
/// AFTER
                _rtext.image_index = 7;
/// CODE
                switch (global.monstertype[myself])
                {
                    case 42:
                        scr_add_goal_progress(51, 1);
                        break;

                    case 55:
                        scr_add_goal_progress(125, 1);
                        break;

                    case 13:
                        scr_add_goal_progress(126, 1);
                        break;
                }
/// END
#endif

/// BEFORE
    defeatanim.sprite_index = sprite_index;
/// CODE
#if !CHAPTER_1
    if (is_recruited && variable_instance_exists(id, "myself") && global.flag[global.monstertype[myself] + 600] == -1)
        scr_add_goal_array(69, "recruits_lost", "enemy" + string(global.monstertype[myself]));
#endif

    scr_add_goal_kills(1);
/// END