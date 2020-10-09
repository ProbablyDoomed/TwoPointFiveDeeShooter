/// @description Create global vars and lists
drawable_3d_sorted = ds_list_create();
drawable_3d_q = ds_priority_create();
//window_set_size(WIDTH*SCALE,HEIGHT*SCALE);
//window_set_rectangle(WIDTH, HEIGHT, WIDTH*SCALE,HEIGHT*SCALE);
WIDTH = window_get_width()/SCALE;
HEIGHT = window_get_height()/SCALE;
depth = -1000;