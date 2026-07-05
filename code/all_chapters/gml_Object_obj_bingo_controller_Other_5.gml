/// IMPORT

prev_interact = global.interact;

#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4
mainchara_was_in_prev_room = instance_exists(obj_mainchara);
#else
mainchara_was_in_prev_room = (instance_exists(obj_mainchara) || instance_exists(obj_plat_player));
#endif