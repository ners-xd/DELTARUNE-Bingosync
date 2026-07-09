<p align="center">
  <img src="assets/deltarune_x_bingosync_logo.png" title="DELTARUNE x Bingosync">
</p>

# DELTARUNE Bingosync Mod
<b>NOTE</b>: The non-Deltamod installations are only supported on:
- Windows Chapters 1-5 (CH1 1.43 / CH2 1.49 / CH3 v0.0.103 / CH4 v0.0.105 / CH5 v0.0.247)
- Switch Chapters 1-5 (CH1 1.31 / CH2 1.37 / CH3 v0.0.100 / CH4 v0.0.103 / CH5 v0.0.240).

This mod connects your game to [Bingosync](https://bingosync.com) and it can automatically mark goals from:
- [this list](https://raw.githubusercontent.com/ners-xd/deltarune-bingosync/refs/heads/ch1-5/assets/goal_list.json)
- or [this list (SRL format)](https://raw.githubusercontent.com/ners-xd/deltarune-bingosync/refs/heads/ch1-5/assets/goal_list_srl_format.json) - this one is separated into 25 categories and only one goal from each category can show up on the board.

You can find a little guide on how to complete most goals [here](https://raw.githubusercontent.com/ners-xd/deltarune-bingosync/refs/heads/ch1-5/assets/goal_requirements.txt). You can also chat with other players, see the board update live and so on.

# How to install and use
- Easiest way: Download [Deltamod](https://gamebanana.com/tools/20575), browse for Bingosync Mod, download it
- OR:
- Download [the latest](https://github.com/ners-xd/deltarune-bingosync/releases/latest) version of the mod
- Import it manually in Deltamod if you downloaded the Deltamod archive
- OR:
- **For Switch:** Use nxdumptool to dump the game files (INCLUDING the update, not just the base application) to your computer **(make sure to use layeredfs dir)**. A tutorial can be found [here](https://www.youtube.com/watch?v=-azK1yjPGQg) if you don't know how
- **Extract the archive anywhere**, run "Bingosync Patcher.bat" and follow its instructions. **On Switch, the game files will be in atmosphere\contents\0100A0D022A68000\romfs**
- Create or join a room on Bingosync, open the game and obtain the room ID from the end of the link (bingosync.com/room/XXXXXXXXXXXXXXXXXXXXXX) and the room's password. Go to "Room & User Info" in the mod and fill everything out
  - If you're creating a room, set the game to **Custom (Advanced)** and the mode to **Randomized** or **SRL** depending on which list you want to use
  - Copy and paste the list into the **Board** section
- Having the chat open automatically progresses text if you're in a cutscene!

# Potential errors while patching
- Couldn't read ROM - The vanilla file couldn't be found, make sure it's named exactly "data.win" (Windows) / "game.win" (Console)
- This patch is not intended for this ROM - The file that's trying to be patched is either not vanilla or not supported. Make sure there's no mods already applied on that file and make sure it's on the list of supported versions (found near the top of this page).

# Hit counter rules
A hit counts as an avoidable loss of HP in battle or in the overworld, including the arcade minigame in Chapter 2 and the Legend of Tenna and Sword boards in Chapter 3.
  - The following do NOT count as hits:
    - Chapter 1: Hitting the white lights in Checkerboard
    - Chapter 2: Being ran over by the overworld cars in Cyber City (including the Toby Fox car in the Egg room), HP depletion due to ThornRing
    - Chapter 3: Getting hit or missing notes in the Cooking and Lightners Live minigames in Boards 1 and 2, Susie taking damage from a bomb after she throws one (it DOES count as a hit if any other character takes damage)
    - Chapter 4: Being pushed by water during the climb sections, taking damage from the unavoidable sword attacks in either Knight chase
  - In addition, for balancing reasons, you can only take up to one hit in these scenarios:
    - Taking damage in the Chapter 2 basement teacup ride
    - Taking damage to the first part of The Knight's sword corridor attack. The part where the swords get launched in random areas counts as a separate hit
    - Taking damage to Balthizard's clouds that only come up when at least one other enemy is in the battle
    - Taking damage to Jackenstein when he catches up to you.

# Contributing
How to contribute to the mod:
- Create a fork of the repo and download the files
- Download [the latest](https://github.com/nhaar/ump/releases/latest) version of UMP and place the script in the same folder as the mod
- Use [the latest](https://github.com/underminersteam/undertalemodtool/releases/latest) version of UndertaleModTool
- Open a chapter's data.win, click on Scripts -> Run other script... -> bingosync_script.csx to import the mod and you can save the file
- You can find a guide on how to use UMP [here](https://github.com/nhaar/ump/blob/main/guide/guide.md)
- If you've made some modifications and you want them to be added in the mod, open a Pull Request and we'll look at it.

# Credits
- Coding:
    - Main mod: Chistosito, NERS
    - Hit counter: marti005
- Goal list: Tadyman, Chistosito, Trinky44, devek1
- Switch version testing: Tadyman
- UMP: nhaar.