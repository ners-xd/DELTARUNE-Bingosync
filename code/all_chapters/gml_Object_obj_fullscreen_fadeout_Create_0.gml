/// IMPORT

persistent = true;
sprite_index = spr_pixel_white;
image_blend = c_black;
image_alpha = 0;
depth = -16000;
x = -display_get_width();
y = -display_get_height();
fadespeed = (os_type == os_macosx) ? 0.14 : 0.08;