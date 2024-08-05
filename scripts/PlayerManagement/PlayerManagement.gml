function grab_spawn_point(_player) {
	var _spawnPoint  = instance_find(obj_SpawnPoint, _player)
	if _spawnPoint == noone return {x:0,y:0};
	return {x:_spawnPoint.x, y:_spawnPoint.y}
}


function create_player(_steamID, _lobbyMemberID) {
	var _layer = layer_get_id("Instances");
	var _pos = grab_spawn_point(_lobbyMemberID); 
	var _steamName = steam_get_user_persona_name_sync(_steamID); 
	
	return instance_create_layer(_pos.x, _pos.y, _layer, obj_Player, {
								steamName	: _steamName, 
								steamID: _steamID, 
								lobbyMemberID: _lobbyMemberID
						}); 
}
