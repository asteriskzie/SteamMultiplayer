/// @description Listening for Activity as Client

// Receive Packets
while(steam_net_packet_receive()){
	
	var _sender = steam_net_packet_get_sender_id();
	steam_net_packet_get_data(inbuf);
	buffer_seek(inbuf, buffer_seek_start, 0);
	var _type = buffer_read(inbuf, buffer_u8);
	
	switch _type{
		case NETWORK_PACKETS.SYNC_PLAYERS:
			var _playerList = buffer_read(inbuf, buffer_string);
			_playerList = json_parse(_playerList)
			sync_players(_playerList)
			break
			
		case NETWORK_PACKETS.SPAWN_OTHER:
		
			var _x = buffer_read(inbuf, buffer_u16)
			var _y = buffer_read(inbuf, buffer_u16)
			var _steamID = buffer_read(inbuf, buffer_u64)
			
			var _local_idx = -1; 
			for (var _i = 0; _i < array_length(playerList); _i++) {
				if (playerList[_i].steamID == _steamID) {
					_local_idx = _i; 
					break; 
				}
			}
			
			// harusnya sih gabakal -1 ya 
			if (_local_idx == -1 || playerList[_local_idx].character == undefined) {
				var _layer = layer_get_id("Instances");
				var _num = array_length(playerList)
				var _inst = instance_create_layer(_x,_y,_layer,obj_Player,{
								steamName : steam_get_user_persona_name(_steamID),
								steamID : _steamID,
								lobbyMemberID : _num
								})
				if (_local_idx == -1) {
					array_push(playerList, {
						steamID	 : _steamID,
						steamName: steam_get_user_persona_name(_steamID),
						character: _inst,
						lobbyMemberID : _num
					}); 
				} else {
					playerList[_local_idx].character = _inst; 
				}
			}
			
			playerList[_local_idx].character.x = _x; 
			playerList[_local_idx].character.y = _y; 
							
			break
			
		case NETWORK_PACKETS.SPAWN_SELF: // setelah dimodif sebenernya jdnya bukan spawn lagi sih wkwkkw
			var _idx = get_idx_playerList(steamID); 
			
			var _x = buffer_read(inbuf, buffer_u16)
			var _y = buffer_read(inbuf, buffer_u16)
			
			if (playerList[_idx].character == undefined) {
				var _layer = layer_get_id("Instances");
				
				var _inst = instance_create_layer(_x,_y,_layer, obj_Player,{
								steamName	: steamName,
								steamID: steamID,
								lobbyMemberID: lobbyMemberID
							})
				playerList[_idx].character = _inst
				character = _inst
			}
			
			character.x = _x; 
			character.y = _y; 
			
			break; 
			
		default:
			show_debug_message("Unknown packet received: " + string(_type)); 
			break; 
	}
}