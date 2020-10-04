/// @description Handle Key Input


if (keyboard_check(vk_alt))
{
	if (keyboard_check(vk_left))	{x += 10*dcos(angle-90); y += 10*dsin(angle-90);}
	if (keyboard_check(vk_right))	{x += 10*dcos(angle+90); y += 10*dsin(angle+90);}
}
else
{
	if (keyboard_check(vk_left))	angle-= 4;
	if (keyboard_check(vk_right))	angle+= 4;
}

if (keyboard_check(vk_up))		{x += 10*dcos(angle); y += 10*dsin(angle);}
if (keyboard_check(vk_down))	{x -= 10*dcos(angle); y -= 10*dsin(angle);}

angle = bound_angle(angle);