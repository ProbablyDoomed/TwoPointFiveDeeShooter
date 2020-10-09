/// @description Insert description here
if (x < other.x) or (x > (other.x + other.sprite_width))
{
	hspeed *= -1;
}
else if (y < other.y) or (y > (other.y + other.sprite_height))
{
	vspeed *= -1;
}