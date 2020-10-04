/// @description Trace rays to prepare texture slices
// You can write your code in this editor

lowest = 
{
	distance : 0,
	column : 0,
	sprite_id : 0
}

x = Player.x;
y = Player.y;
angle = Player.facing_angle;

#region function declaration
function intersect_vertical(x_test,line)
{
	return (line.m*x_test) + line.c;
}

function intersect_horizontal(y_test,line)
{
	return (y_test - line.c) / line.m;
}

function update_if_lower_distance(test_x,test_y,test_sprite_index,vert_edge)
{
	var test_angle = darctan((test_y - Camera.y)/(test_x - Camera.x)) - Camera.angle;		
	
	if(test_x < Camera.x) test_angle += 180;
	if(test_angle >= 180) test_angle -= 360;
	if(test_angle <= -180) test_angle += 360;	
	
	//test_angle = bound_angle(test_angle);	
	
	if(test_angle < 90 && test_angle > -90)
	{		
		var test_dist = sqrt(sqr(test_x - Camera.x)+sqr(test_y - Camera.y)); 
		if(test_dist < Camera.lowest.distance && test_dist > Camera.drawMin)
		{
			Camera.lowest.distance = test_dist;
			Camera.lowest.sprite_id = test_sprite_index;
			if(vert_edge)
			{
				Camera.lowest.column = test_y % sprite_get_width(test_sprite_index);
			}
			else
			{
				Camera.lowest.column = test_x % sprite_get_width(test_sprite_index);
			}
		}
	}
}
#endregion

for(var ray = 0; ray < WIDTH; ray++)
{
	var ray_angle = angle - fov + (ray * 2 * fov / WIDTH);
	//y=mx+c
	var ray_line =
	{
		//ang: ray_angle,
		m : dtan(ray_angle),
		c : 0,
	}
	ray_line.c = y - (ray_line.m*x);
	
	//show_debug_message("ray_angle: "+string(ray_angle-angle));	
	
	lowest.distance = drawMax;
	with(Wall)
	{
		var top_edge_y = y, bottom_edge_y = y + sprite_height;
		var left_edge_x = x, right_edge_x = x + sprite_width;
		
		var top_intersect_x = intersect_horizontal(top_edge_y,ray_line);
		var bottom_intersect_x = intersect_horizontal(bottom_edge_y,ray_line);
		var left_intersect_y = intersect_vertical(left_edge_x,ray_line);
		var right_intersect_y = intersect_vertical(right_edge_x,ray_line);		
		
		if(top_intersect_x >= left_edge_x && top_intersect_x <= right_edge_x) 
			update_if_lower_distance(top_intersect_x,top_edge_y,sprite_index,false);
			
		if(bottom_intersect_x >= left_edge_x && bottom_intersect_x <= right_edge_x) 
			update_if_lower_distance(bottom_intersect_x,bottom_edge_y,sprite_index,false);
			
		if(left_intersect_y >= top_edge_y && left_intersect_y <= bottom_edge_y) 
			update_if_lower_distance(left_edge_x,left_intersect_y,sprite_index,true);
			
		if(right_intersect_y >= top_edge_y && right_intersect_y <= bottom_edge_y) 
			update_if_lower_distance(right_edge_x,right_intersect_y,sprite_index,true);
	}
	
	var new_slice = 
	{
		dist : lowest.distance,
		col : lowest.column,
		spr_id : lowest.sprite_id,
		scr_x : ray
	}
	
	if(new_slice.dist < drawMax && new_slice.dist > drawMin)
	{
		ds_priority_add(wall_slices_q, new_slice, new_slice.dist);
	}		
}

var lim = ds_priority_size(wall_slices_q);
ds_list_clear(wall_slices_sorted);
for (var i = 0; i < lim; i += 1) 
{
	ds_list_insert(wall_slices_sorted,i,ds_priority_delete_min(wall_slices_q));
}

ds_priority_clear(wall_slices_q);



