/// @description Handle Key Input

if (keyboard_check(vk_alt))
{
	if (keyboard_check(vk_left))	{x += v_move*dcos(facing_angle-90); y += v_move*dsin(facing_angle-90);}
	if (keyboard_check(vk_right))	{x += v_move*dcos(facing_angle+90); y += v_move*dsin(facing_angle+90);}
}
else
{
	if (keyboard_check(vk_left))	facing_angle -= turn_rate;
	if (keyboard_check(vk_right))	facing_angle += turn_rate;
}

if (keyboard_check(vk_up))		{x += v_move*dcos(facing_angle); y += v_move*dsin(facing_angle);}
if (keyboard_check(vk_down))	{x -= v_move*dcos(facing_angle); y -= v_move*dsin(facing_angle);}

facing_angle = bound_angle(facing_angle);

if (keyboard_check(vk_control)) 
{
	var inst = instance_create_depth(x, y, 0, AbstractProjectile);
	with (inst)
	{
		speed = other.v_move * 4  + random_range(-0,2);
		direction = 360 - other.facing_angle + random_range(-1,1);
		sprite_rotation = random_range(0,360);
	}

}

