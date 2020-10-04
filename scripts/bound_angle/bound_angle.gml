// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bound_angle(ang_input){
	if(ang_input > 180) return ang_input - 360;
	else if(ang_input < -180) return ang_input + 360;
	else return ang_input;
}