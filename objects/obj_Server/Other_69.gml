switch(async_load[?"event_type"])
{ 
	case "lobby_chat_update":
		// when someone enter 
		var _fromID = async_load[?"user_id"]; //SteamID
		var _fromName = steam_get_user_persona_name_sync(_fromID); //Steam Player Name
		if (async_load[?"change_flags"] & steam_lobby_member_change_entered){
			show_debug_message("Player Joined: " + _fromName); 
			
			var _slot = -1; 
			
			for (var _i = 0; _i < 4; _i++) {
				if (playerList[_i] == undefined) {
					_slot = _i; 
					break; 
				}
			}
			
			if (_slot == -1) show_debug_message("[ERROR] slot ga ketemu"); 
			var _newCharacter = create_player(_fromID, _slot); 
			var _newPlayer = {
				steamID: _fromID, 
				steamName: _fromName, 
				character: _newCharacter, 
				startPos: grab_spawn_point(_slot), 
				lobbyMemberID: _slot,
			}
			playerList[_slot] = _newPlayer; 		
			
			// send the server's playerlist to the new player's interface
			send_player_sync(_fromID);
			
			// spawn the players to the new player's interface
			send_player_spawn(_fromID, _newPlayer.lobbyMemberID);

		} else if (async_load[?"change_flags"] & steam_lobby_member_change_left){
			show_debug_message("Player Left: " + _fromName); 
			
			var _slot = get_idx_playerList(_fromID);
			
			if (_slot == -1) show_debug_message("[ERROR] player yg leave emg blm masuk playerList");
			
			if (0 <= _slot && _slot < 4) {
				instance_destroy(playerList[_slot].character); 
				// TODO: mungkin perlu destroy struct nya dari game ga? 
				playerList[_slot] = undefined; 
			}						
			
			// TODO: notify everyone that this player has left 
			//send_player_sync(_fromID);
			
		}
		
		break; 
}



