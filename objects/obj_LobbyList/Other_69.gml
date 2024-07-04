/// @description Listen for Server List Response 

switch (async_load[? "event_type"]) {
	case "lobby_list": 
		show_debug_message("[DEBUG] Inside obj_LobbyList async, event type lobby_list"); 
		reset_lobby_list(); 
		
		show_debug_message("[DEBUG] After reset lobby list, array size = " + string(array_length(lobby_list))); 
		
		if (steam_lobby_list_get_count() == 0) {
			show_debug_message("[DEBUG] Lobby not found"); 
			lobby_list[0] = instance_create_depth(x, bbox_top+40, -20, obj_LobbyItem); 
	
		} else {
			show_debug_message("[DEBUG] Lobby found, count = " + string(steam_lobby_list_get_count())); 
			
			for (var _i = 0; _i < steam_lobby_list_get_count(); _i++) {
				show_debug_message("[DEBUG] the " + string(_i) + "-th lobby id is " + string(steam_lobby_list_get_lobby_id(_i))); 
				var _ins = instance_create_depth(x, bbox_top+40+80*_i, -20, obj_LobbyItem, {
					lobby_index		: _i, 
					lobby_id		: steam_lobby_list_get_lobby_id(_i), 
					lobby_creator	: steam_lobby_list_get_data(_i, "Creator")
				}); 
				array_push(lobby_list, _ins); 
			}
		}
	
	break 
	
}
