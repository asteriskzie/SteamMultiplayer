/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

selectAction = function() {
	
	global.server = instance_create_depth(0,0,0,obj_Server)
	//room_goto(rm_GameRoom)
	
	// tell steam to create lobby, we wait for response -> lobby ID from steam
	steam_lobby_create(steam_lobby_type_public, 4); 
	
}