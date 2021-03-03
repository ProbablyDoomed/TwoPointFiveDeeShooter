/// @description Insert description here

life_left = lifetime;
if(hitscan) 
{
	show_debug_message("**FIRE!** "+string(direction));
	//speed = 1;
	while( valid_position(x,y) && life_left > 0)
	{
		x += hitscan_step*dcos(direction); 
		y += hitscan_step*dsin(direction);
		life_left--;
		show_debug_message(string(x)+" , "+string(y));
	}
	show_debug_message("**IMPACT!** "+string(life_left));
}
