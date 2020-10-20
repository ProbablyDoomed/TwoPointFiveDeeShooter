/// @description Insert description here
// You can write your code in this editor
var mag = sqrt(sqr(Player.v_y)+sqr(Player.v_x));
var dir = darctan(Player.v_y/Player.v_x);
draw_text(0,0,string(Player.v_x)+","+string(Player.v_y));
draw_text(0,32,string(mag)+","+string(dir));

/*
var radar_x = 128;
var radar_y = 128;
var radar_r = 64;
var radar_d = 4;

var dot_x = radar_x + Player.v_x * radar_r / Player.v_acc;
var dot_y = radar_y + Player.v_y * radar_r / Player.v_acc;

draw_circle(radar_x,radar_y,radar_r,true);
draw_rectangle(dot_x - radar_d,dot_y - radar_d,dot_x + radar_d,dot_y + radar_d, false);
*/