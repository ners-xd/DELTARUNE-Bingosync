<p align="center">
  <img src="deltarune_x_bingosync_logo.png" title="DELTARUNE x Bingosync">
</p>

# DELTARUNE Bingosync Mod
<b>NOTE</b>: This mod is only supported on Chapter 1&2 LTS v3 (1.19).

This mod connects your game to [Bingosync](https://bingosync.com) and it can automatically mark goals from [this list](https://raw.githubusercontent.com/ners-xd/deltarune-bingosync/refs/heads/ch1%262/goal_list.json). You can find a little guide on how to complete each goal [here](https://raw.githubusercontent.com/ners-xd/deltarune-bingosync/refs/heads/ch1%262/goal_requirements.txt). You can also chat with other players, see the board update live, star goals and change your name color.

# How to install and use
- This mod was only tested on Windows and it's currently unknown if it's supported on Mac. If you have macOS and want to test it, use game.ios instead of data.win in the following steps. Linux is not supported at all because the game_change() function doesn't work;
- Download [the latest](https://github.com/ners-xd/deltarune-bingosync/releases/latest) version of the mod;
- Back up your chapters' vanilla data.win files;
- Use your preferred ROM Patcher to apply the patches to each of the vanilla data.win files. If you don't have any, I recommend using [this one](https://www.marcrobledo.com/RomPatcher.js) (place the original file in the ROM section and the mod in the Patch section);
- Rename your vanilla files to something else and rename the modded ones to data.win so the game can recognize them;
- Create or join a room on Bingosync, open the game and obtain the room ID from the end of the link (bingosync.com/room/XXXXXXXXXXXXXXXXXXXXXX) and the room's password. Choose a nickname and a color (orange, red, blue, green, purple, navy, teal, brown, pink or yellow) and press "Connect to room";
- In this menu you can also reset your goal progress if needed (in case there's a bug or you just want to reset it, for some reason) and change your preferences.
- Having the chat open automatically progresses text if you're in a cutscene!

# Current quirks
- You can't open the chat while holding Control or Shift;
- Occasionally, messages might pop up in chat saying you disconnected, but you actually didn't.

# Contributing
How to contribute to the mod:
- Create a fork of the repo and download the files;
- Download [the latest](https://github.com/nhaar/ump/releases/latest) version of UMP and place the script in the same folder as the mod;
- Use [the latest](https://github.com/UnderminersTeam/UndertaleModTool/releases/latest) version of UndertaleModTool;
- Open a chapter's data.win, click on Scripts -> Run other script... -> bingosync_script.csx to import the mod and you can save the file;
- You can find a guide on how to use UMP [here](https://github.com/nhaar/ump/blob/main/guide/guide.md);
- If you've made some modifications and you want them to be added in the mod, open a Pull Request and we'll look at it.

# Credits
- Coding: Chistosito, NERS;
- Goal list: Tadyman, Chistosito, Trinky44, devek1;
- UMP: nhaar.
