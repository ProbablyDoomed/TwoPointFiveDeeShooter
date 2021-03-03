/// @description Insert description here
var inst = instance_create_depth(x, y, 0, Bullet);
	inst.speed = 48;
	inst.direction = 360 - facing_angle + random_range(-1,1);
	/*with (inst)
	{
		direction = 360 - other.facing_angle + random_range(-1,1);
		//sprite_rotation = random_range(0,360);
	}*/