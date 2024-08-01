/// @description Listening for Activity as Server

// Receive Packets
while(steam_net_packet_receive()){
	
	var _sender = steam_net_packet_get_sender_id();
	steam_net_packet_get_data(inbuf);
	buffer_seek(inbuf, buffer_seek_start, 0);
	var _type = buffer_read(inbuf, buffer_u8);
	
	switch _type{
		case NETWORK_PACKETS.MOVE_PLAYER: 
			var _move_x = buffer_read(inbuf, buffer_s16); 
			var _move_y = buffer_read(inbuf, buffer_s16); 
			var _player_steamID = buffer_read(inbuf, buffer_u64); 
			
			show_debug_message("[deb] Got command to move x by " + string(_move_x )); 
			show_debug_message("[deb] Got command to move y by " + string(_move_y )); 
			show_debug_message("[deb] Player to move is " + string(steam_get_user_persona_name_sync(_player_steamID))); 
			
			
			for (var _i = 0; _i < array_length(playerList); _i++) {
				if (playerList[_i].steamID == _player_steamID) {
					show_debug_message("jadi harusnya masalahnya setelah ini");
					show_debug_message(typeof(_move_x));
					
					if (playerList[_i].character != undefined) {
						playerList[_i].character.x += _move_x; 
					show_debug_message("kalo ini ga muncul berarti bener masalahnya ini"); 
					playerList[_i].character.y += _move_y;
					
					}
					 
					
					send_player_spawn(_player_steamID, playerList[_i].lobbyMemberID); 
					
					show_debug_message("[deb] Actually did it");
				}
				
			}
			
			
			break;
			
		//case NETWORK_PACKETS.SYNC_PLAYERS:
		//	var _playerList = buffer_read(inbuf, buffer_string);
		//	_playerList = json_parse(_playerList)
		//	sync_players(_playerList)
		//	break
		//case NETWORK_PACKETS.SPAWN_OTHER:
		//	var _layer = layer_get_id("Instances");
		//	var _x = buffer_read(inbuf, buffer_u16)
		//	var _y = buffer_read(inbuf, buffer_u16)
		//	var _steamID = buffer_read(inbuf, buffer_u64)
		//	var _num = array_length(playerList)
		//	var _inst = instance_create_layer(_x,_y,_layer,obj_Player,{
		//					steamName : steam_get_user_persona_name(_steamID),
		//					steamID : _steamID,
		//					lobbyMemberID : _num
		//					})
		//	array_push(playerList, {
		//		steamID	 : _steamID,
		//		steamName: steam_get_user_persona_name(_steamID),
		//		character: _inst,
		//		lobbyMemberID : _num
		//	})
				
		//	break
			
		//case NETWORK_PACKETS.SPAWN_SELF:
		//	for (var _i = 0; _i < array_length(playerList); _i++){
		//		if playerList[_i].steamID == steamID then lobbyMemberID = playerList[_i].lobbyMemberID	
		//	}
		//	var _layer = layer_get_id("Instances");
		//	var _x = buffer_read(inbuf, buffer_u16)
		//	var _y = buffer_read(inbuf, buffer_u16)
		//	var _inst = instance_create_layer(_x,_y,_layer,obj_Player,{
		//					steamName	: steamName,
		//					steamID: steamID,
		//					lobbyMemberID: lobbyMemberID
		//				})
		//	playerList[0].character = _inst
		//	character = _inst
		//	break
		
		default:
			show_debug_message("Unknown packet received: "+string(_type))
			break
	}
}