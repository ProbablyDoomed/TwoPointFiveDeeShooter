/// @description Handle Key Input

var turn = 0;
var walk = 0;
var strafe = 0;

if (keyboard_check(vk_alt))
{
	if		(keyboard_check(vk_left))	strafe = -1;
	else if (keyboard_check(vk_right))	strafe =  1;
}
else
{
	if		(keyboard_check(vk_left))	turn = -1;
	else if (keyboard_check(vk_right))	turn =  1;
}

if		(keyboard_check(ord("A")))	strafe = -1;
else if (keyboard_check(ord("D")))	strafe =  1;

if		(keyboard_check(ord("Q")))	turn = -1;
else if (keyboard_check(ord("E")))	turn =  1;

if		(keyboard_check(vk_up) || keyboard_check(ord("W")))		walk =  1;
else if (keyboard_check(vk_down) || keyboard_check(ord("S")))	walk = -1;

if		(turn == -1)	facing_angle -= keyboard_turn_rate;
else if (turn ==  1)	facing_angle += keyboard_turn_rate;

var mouse_diff = display_mouse_get_x() - m_x;
facing_angle += mouse_turn_rate * mouse_diff;
window_mouse_set(Camera.SCALE*Camera.WIDTH/2,Camera.SCALE*Camera.HEIGHT/2);
m_x = display_mouse_get_x();

v_x *= v_fric; v_y *= v_fric;
if		(strafe == -1)	{v_x += v_acc*dcos(facing_angle-90); v_y += v_acc*dsin(facing_angle-90);}
else if (strafe ==  1)	{v_x += v_acc*dcos(facing_angle+90); v_y += v_acc*dsin(facing_angle+90);}
if		(walk =  1)		{v_x += v_acc*dcos(facing_angle); v_y += v_acc*dsin(facing_angle);}
else if (walk = -1)		{v_x -= v_acc*dcos(facing_angle); v_y -= v_acc*dsin(facing_angle);}

if		(valid_position(x + v_x, y + v_y ))	{ x += v_x;	y += v_y; }
else if	(valid_position(x + v_x, y		 ))	{ x += v_x;           }
else if	(valid_position(x,       y + v_y ))	{           y += v_y; }

facing_angle = bound_angle(facing_angle);
