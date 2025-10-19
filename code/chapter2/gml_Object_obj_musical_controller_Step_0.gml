/// PATCH

/// AFTER
if (scon == 1.5 && !instance_exists(obj_writer))
{
/// CODE
    if ((instance_exists(obj_sweet_enemy) && obj_sweet_enemy.dancing) || (instance_exists(obj_kk_enemy) && obj_kk_enemy.dancing) || (instance_exists(obj_hatguy) && obj_hatguy.dancing))
        cheese = true;
/// END