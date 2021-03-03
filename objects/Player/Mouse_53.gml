/// @description Insert description here
var inst = instance_create_depth(x, y, 0, EldritchBlast);
	inst.speed = 48  + random_range(-0,2);
	inst.direction = 360 - facing_angle + random_range(-1,1);
	inst.sprite_rotation = random_range(0,360);
	/*with (inst)
	{
		speed = 48  + random_range(-0,2);
		direction = 360 - other.facing_angle + random_range(-1,1);
		sprite_rotation = random_range(0,360);
	}*/