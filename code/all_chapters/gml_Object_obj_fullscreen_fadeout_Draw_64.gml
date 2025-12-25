/// IMPORT

image_alpha += fadespeed;
draw_sprite_ext(sprite_index, image_index, x, y, -x, -y, 0, image_blend, image_alpha);
audio_set_master_gain(0, audio_get_master_gain(0) - (1 / (100 * fadespeed)));
global.interact = 1;