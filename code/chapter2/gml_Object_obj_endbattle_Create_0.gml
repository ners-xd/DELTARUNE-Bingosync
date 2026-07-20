/// PATCH

/// PREPEND
switch (global.encounterno)
{
    case 58:
        scr_add_goal_array(34, "berdly1");
        break;

    case 83:
        if (global.flag[644] != 1)
            scr_add_goal_progress(61, 1);
        else
            scr_add_goal_spares(1); // Mauswheel spare workaround
        break;

    case 81:
        if (global.flag[640] == 1)
            scr_add_goal_progress(52, 1);
        break;

    case 56:
        if (room == room_dw_mansion_potBalance && !global.failed_pot_balance)
            global.failed_pot_balance = true;
        break;

    case 102:
        if (global.mspipis_encountered)
            global.mspipis_attempts = 0;
        break;
}
/// END