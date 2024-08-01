switch(async_load[?"event_type"])
{ 
	case "lobby_chat_update":
		// when someone enter 
		var _fromID = async_load[?"user_id"]; //SteamID
		var _fromName = steam_get_user_persona_name_sync(_fromID); //Steam Player Name
		if (async_load[?"change_flags"] & steam_lobby_member_change_entered){
			show_debug_message("Player Joined: " + _fromName)
			var _slot = array_length(playerList)
			array_push(playerList, 
			{
				steamID: _fromID,
				steamName: _fromName,
				character: undefined,
				startPos: grab_spawn_point(_slot),
				lobbyMemberID: _slot
			})
			
			if (playerList[0].character == undefined) show_debug_message("POSISI A"); 
			// send the server's playerlist to the new player's interface
			send_player_sync(_fromID);
			if (playerList[0].character == undefined) show_debug_message("POSISI B"); 
			
			// spawn the players to the new player's interface
			send_player_spawn(_fromID, _slot);
			if (playerList[0].character == undefined) show_debug_message("POSISI C"); 
		} else if (async_load[?"change_flags"] & steam_lobby_member_change_left){
			show_debug_message("Player Left: " + _fromName)
			for (var _i = 0; _i < array_length(playerList); _i++) {
				if (playerList[_i].steamID == _fromID) {
					instance_destroy(playerList[_i].character);
					playerList[_i] = undefined; 
				}
				
			}
			
			//send_player_sync(_fromID);
			
		}
		break; 
}



