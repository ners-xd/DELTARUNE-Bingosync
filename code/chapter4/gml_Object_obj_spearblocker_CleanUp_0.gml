/// PATCH

/// APPEND
if (!instance_exists(obj_hammer_of_justice_enemy) || (instance_exists(obj_hammer_of_justice_enemy) && obj_hammer_of_justice_enemy.attackpattern != 53))
    global.grazed_at_all = false;
/// END