///@self obj_Client 
function add_to_playerList(_newPlayer) {
	var _idx = -1; 
	
	for (var _i = 0; _i < 4; _i++) {
		if (playerList[_i] == undefined) {
			playerList[_i] = _newPlayer; 
			_idx = _i; 
			break; 
		} 
	}
	
	if (_idx == -1) {				
		var _name = _newPlayer.steamName; 
		show_debug_message("Fail to add player " + _name); 
	}
	
	return _idx; 
} 


///@self obj_Client 
function is_in_playerList(_steamID) {
	for (var _i = 0; _i < 4; _i++) {
		if (playerList[_i] != undefined && playerList[_i].steamID == _steamID) {
			return true; 
		} 
	}
	return false; 
}

///@self obj_Client
function sync_players(_new_list) {
	// _new_list is the correct list from server 
	
	for (var _i = 0; _i < array_length(_new_list); _i++){
		var _newSteamID	= _new_list[_i].steamID; 
		
		if (is_in_playerList(_newSteamID)) { 
			var _k = get_idx_playerList(_newSteamID); 
			
			playerList[_k].startPos = _new_list[_i].startPos;
			playerList[_k].lobbyMemberID = _new_list[_i].lobbyMemberID;
			if  (playerList[_k].character == undefined) {
				var _inst = client_player_spawn_at_pos(playerList[_k])
				playerList[_k].character = _inst
			}
			
			//for (var _k = 0; _k < array_length(playerList); _k++) {
			//	if (playerList[_k].steamID == _newSteamID) {
			//		playerList[_k].startPos = _new_list[_i].startPos
			//		playerList[_k].lobbyMemberID = _new_list[_i].lobbyMemberID
			//		if  playerList[_k].character == undefined && playerList[_k].steamID != _newSteamID{
			//			var _inst = client_player_spawn_at_pos(playerList[_k])
			//			playerList[_k].character = _inst
			//		}
			//	}
			//}
			
		} else {			
			var _idx = add_to_playerList(_new_list[_i]); 
			var _inst = client_player_spawn_at_pos(playerList[_idx]); 
			playerList[_idx].character = _inst; 
			
			if (_newSteamID == steamID) {
				// my player 
				character = _inst; 
				lobbyMemberID = playerList[_idx].lobbyMemberID; 
			}
						
		}
	}
}

///@self obj_Client
function client_player_spawn_at_pos(_player_info) {
	var _layer	= layer_get_id("Instances")
	var _name	= _player_info.steamName
	var _steamID= _player_info.steamID
	var _num	= _player_info.lobbyMemberID
	var _loc	= _player_info.startPos
	var _inst	= instance_create_layer(_loc.x, _loc.y, _layer, obj_Player, {
		steamName	 :	_name,
		steamID		 :	_steamID,
		lobbyMemberID:	_num
	})
	return _inst
}