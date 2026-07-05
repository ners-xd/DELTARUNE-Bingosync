#load "main.csx"

switch(Data?.GeneralInfo?.DisplayName?.Content)
{
    /*
    Nintendo Switch Chapter 3-5 game.win files still
    have the name DELTARUNE Chapter 1&2
    */
    case "DELTARUNE Chapter 1&2":
        if(Data?.GameObjects?.ByName("obj_intro_ch5") != null)
        {
            BuildMod(5);
        }
        else if(Data?.GameObjects?.ByName("obj_intro_ch4") != null)
        {
            BuildMod(4);
        }
        else if(Data?.GameObjects?.ByName("obj_intro_ch3") != null)
        {
            BuildMod(3);
        }
        else
        {
            goto default;
        }
        return;

    case "DELTARUNE":
        BuildMod(0);
        return;

    case "DELTARUNE Chapter 1":
        BuildMod(1);
        return;

    case "DELTARUNE Chapter 2":
        BuildMod(2);
        return;

    case "DELTARUNE Chapter 3":
        BuildMod(3);
        return;

    case "DELTARUNE Chapter 4":
        BuildMod(4);
        return;

    case "DELTARUNE Chapter 5":
        BuildMod(5);
        return;

    case "DELTARUNE Chapter 6":
        BuildMod(6);
        return;

    case "DELTARUNE Chapter 7":
        BuildMod(7);
        return;

    default:
        ScriptError("Invalid game. Use DELTARUNE Chapter Select or DELTARUNE Chapter 1-7.");
        return;
}