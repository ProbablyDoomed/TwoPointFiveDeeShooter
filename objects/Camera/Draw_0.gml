///@description Draw slices	

//draw_sprite(wall_WolfBrick,0,0,0);


for (var c = 0; c < ds_list_size(wall_slices_sorted); c+=1) 
{
	var slice = ds_list_find_value(wall_slices_sorted,c);
	
	var relative_angle = 0 - fov + (slice.scr_x * 2 * fov/WIDTH);
	
	var pixel_height = sprite_get_height(slice.spr_id);
	
	var draw_height = (pixel_height*WIDTH/(2*dtan(fov)*(slice.dist * dcos(relative_angle))));
	
	var draw_y = (HEIGHT - draw_height) / 2;
	
	var scale_y = draw_height / pixel_height;
	
	draw_sprite_part_ext(slice.spr_id, -1,
		slice.col, 0,
		1, pixel_height,
		slice.scr_x * SCALE, draw_y * SCALE,
		SCALE, scale_y * SCALE,
		c_white, 1);
}

draw_rectangle(0, 0, WIDTH*SCALE, HEIGHT*SCALE, true);
draw_text_transformed_color(WIDTH*SCALE/2, HEIGHT*SCALE/2, string(Camera.angle),2,2,0,c_red,c_red,c_red,c_red,1);