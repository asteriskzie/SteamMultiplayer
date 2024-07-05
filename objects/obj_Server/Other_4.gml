/// @description Spawn Players

var _playerLayer = layer_get_id("Instances"); 

for (var _player = 0; _player < array_length(playerList); _player++) {
	var _pos = grab_spawn_point(_player); 
	var _inst = instance_create_layer(_pos.x, _pos.y, _playerLayer, obj_Player, {
		steamName	: playerList[_player].steamName, 	
		steamID		: playerList[_player].steamID, 
		lobbyMemberID: _player
	}); 
	
	playerList[_player].startPos = _pos; 
	playerList[_player].character = _inst; 
	
	show_debug_message("_inst stem id = " + string(_inst.steamID)); 
	if _inst.steamID == steamID then character = _inst 
}