///@description Draw slices	

var ceiling_colour_far = c_black
var ceiling_colour_near = make_colour_rgb(brightness/2, brightness/2, brightness/2);
var floor_colour_far = c_black;
var floor_colour_near = make_colour_rgb(brightness/4, brightness/4, brightness/4);

draw_rectangle_color(0,0,WIDTH*SCALE,HEIGHT*SCALE/2,ceiling_colour_near,ceiling_colour_near,ceiling_colour_far,ceiling_colour_far,false)
draw_rectangle_color(0,HEIGHT*SCALE/2,WIDTH*SCALE,HEIGHT*SCALE,floor_colour_far,floor_colour_far,floor_colour_near,floor_colour_near,false)


var lim = ds_priority_size(drawable_3d_q);
for (var i = 0; i < lim; i += 1) 
//for (var c = 0; c < ds_list_size(drawable_3d_sorted); c+=1) 
{
	var drawable_3d = ds_priority_delete_max(drawable_3d_q);
	//var drawable_3d = ds_list_find_value(drawable_3d_sorted,c);
	
	var relative_angle = 0 - fov + (drawable_3d.scr_x * 2 * fov/WIDTH);
	
	var pixel_height = sprite_get_height(drawable_3d.spr_id);
	
	var draw_height = (pixel_height*WIDTH/(2*dtan(fov)*(drawable_3d.dist * dcos(relative_angle))));	
	
	var scale_sprite = draw_height / pixel_height;
	
	var fog_blend = 0;
	if(drawable_3d.dist < fog_distance)
	{
		fog_blend = brightness*(1 - (drawable_3d.dist/fog_distance));
	}
	
	var col_blend = make_colour_rgb(fog_blend, fog_blend, fog_blend);
	
	if(drawable_3d.col == -1)
	{
		var draw_y = (HEIGHT + (64*scale_sprite) - draw_height) / 2;		
		
		draw_sprite_ext(drawable_3d.spr_id, -1,
		drawable_3d.scr_x * SCALE, draw_y * SCALE,
		scale_sprite * SCALE, scale_sprite * SCALE, 0,
		col_blend, 1);//(draw_height/HEIGHT));
	}
	else
	{
		var draw_y = (HEIGHT - draw_height) / 2;
		draw_sprite_part_ext(drawable_3d.spr_id, -1,
			drawable_3d.col, 0,
			1, pixel_height,
			drawable_3d.scr_x * SCALE, draw_y * SCALE,
			SCALE, scale_sprite * SCALE,
			col_blend, 1);//(draw_height/HEIGHT));
	}
}

ds_priority_clear(drawable_3d_q);

//draw_rectangle(0, 0, WIDTH*SCALE, HEIGHT*SCALE, true);
//draw_text_transformed_color(WIDTH*SCALE/2, HEIGHT*SCALE/2, string(Camera.angle),2,2,0,c_red,c_red,c_red,c_red,1);