// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function valid_position(x_collide, y_collide){
	var collide = place_meeting(x_collide, y_collide, AbstractWall) 
		|| place_meeting(x_collide, y_collide, AbstractTangible) 
		|| place_meeting(x_collide, y_collide, AbstractEntity);
	
	return !collide;
}