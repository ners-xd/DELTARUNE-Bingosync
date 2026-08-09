#load "ump.csx"

using System.Linq;
using System.Drawing;
using UndertaleModLib.Util;

UndertaleModLib.Compiler.CodeImportGroup importGroup = new(Data);

class BingoLoader : UMPLoader
{
    public override string CodePath => "code/";

    public override bool UseGlobalScripts => true;

    public override string[] Symbols => chnum switch
    {
        0 => new[] { "CHAPTER_SELECT" },
        1 => new[] { "CHAPTER_1" },
        2 => new[] { "CHAPTER_2" },
        3 => new[] { "CHAPTER_3" },
        4 => new[] { "CHAPTER_4" },
        5 => new[] { "CHAPTER_5" },
        6 => new[] { "CHAPTER_6" },
        7 => new[] { "CHAPTER_7" },
        _ => throw new NotImplementedException()
    };

    public override string[] GetCodeNames(string filePath)
    {
        List<string> entries = new List<string>();
        string fileName = Path.GetFileNameWithoutExtension(filePath);

        if(filePath.Contains("universal") || (chnum > 0 && filePath.Contains("all_chapters")) || filePath.Contains(chnum == 0 ? "chapter_select" : $"chapter{chnum}"))
            entries.Add(fileName);

        return entries.ToArray();
    }

    public BingoLoader(UMPWrapper wrapper, int chapter) : base(wrapper)
    {
        chnum = chapter;
    }

    public int chnum { get; set; }

    public enum DR
    {
        MaxChapter = 5
    }

    public string GetModVersion()
    {
        return "\"3.11\"";
    }

    public string GetBranchName()
    {
        return "\"ch1-5\"";
    }

    public string GetBingoFile()
    {
        return "\"bingo_data.json\"";
    }
}

void BuildMod(int chapter)
{
    // Change save file location (PC)
    Data.GeneralInfo.Name = Data.Strings.MakeString("DELTARUNE_bingosync_mod");

    BingoLoader loader = new BingoLoader(UMP_WRAPPER, chapter);
    string scriptPath = Path.GetDirectoryName(ScriptPath);

    if(chapter > 0)
        RunUMTScript(Path.Combine(scriptPath, "sprites/ImportGraphics.csx"));

    // Import fnt_main from Chapter 1 into other chapters because for some reason the text acts really strange otherwise.
    // For example, the m/M and w/W letters on the board are shifted down-right IF you enter from Chapter Select and you're not on fullscreen.
    if(chapter > 1)
        RunUMTScript(Path.Combine(scriptPath, "fnt_main_ch1/ImportFonts.csx"));

    loader.Load();

    List<UndertaleCode> toDump = Data.Code.Where(c => c.ParentEntry is null).ToList();
    foreach(UndertaleCode code in toDump)
    {
        if(code is null)
            continue;

        if(code.Name.Content != "gml_GlobalScript_game_restart_true")
            importGroup.QueueFindReplace(code, "game_restart(", "game_restart_true(", true);

        // Change save file location (Console)
        if(code.Name.Content != "gml_GlobalScript_universal_bingo_functions")
            importGroup.QueueFindReplace(code, "deltarune.sav", "DELTARUNE_bingosync_mod.sav", true);
    }
    importGroup.Import();

    ScriptMessage(chapter == 0 ? "Bingosync Mod for DELTARUNE Chapter Select was imported!" : $"Bingosync Mod for DELTARUNE Chapter {chapter} was imported!");
}