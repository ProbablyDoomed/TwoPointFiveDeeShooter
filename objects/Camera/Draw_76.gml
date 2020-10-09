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

function intersect_line_segment()
{

}

function calculate_angle(a_x,a_y)
{
	var result_angle = darctan((a_y - Camera.y)/(a_x - Camera.x)) - Camera.angle;	
	if(a_x < Camera.x) result_angle += 180;
	if(result_angle >= 180) result_angle -= 360;
	if(result_angle <= -180) result_angle += 360;	
	return result_angle;
}

function calculate_distance(target_x,target_y,target_angle)
{
	var target_dist = Camera.drawMax;	
	if(target_angle < 90 && target_angle > -90)
	{		
		target_dist = sqrt(sqr(target_x - Camera.x)+sqr(target_y - Camera.y)); 
	}
	
	return target_dist;
}

function update_if_lower_distance(test_x,test_y,test_sprite_index,vert_edge)
{
	var test_dist = Camera.calculate_distance(test_x,test_y, 
		Camera.calculate_angle(test_x,test_y));
	
	if(test_dist < Camera.lowest.distance 
		&& test_dist > Camera.drawMin 
		&& test_dist < Camera.drawMax)
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
		
	lowest.distance = drawMax;
	with(AbstractWall)
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
	
	var wall_slice = 
	{
		dist : lowest.distance,
		col : lowest.column,
		spr_id : lowest.sprite_id,
		scr_x : ray,
		rotation : 0,
		off : 0
	}
	
	if(wall_slice.dist < drawMax 
		&& wall_slice.dist > drawMin)
	{
		ds_priority_add(drawable_3d_q, wall_slice, wall_slice.dist);
	}		
	
}

with(AbstractThing)
{		
	var thing_angle = Camera.calculate_angle(x,y);
	var thing_dist = Camera.calculate_distance(x,y,thing_angle);			

	var thing3d = 
	{
		dist : thing_dist,
		col : -1,
		spr_id : sprite_index,
		scr_x : (thing_angle + Camera.fov) * Camera.WIDTH / (Camera.fov*2),
		rot : sprite_rotation,
		off : sprite_vert_offset
	}

	if(thing3d.dist < Camera.drawMax 
		&& thing3d.dist > Camera.drawMin)
	{
		ds_priority_add(Camera.drawable_3d_q, thing3d, thing3d.dist);
	}
}




