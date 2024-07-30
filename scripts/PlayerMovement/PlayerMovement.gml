function paddle_movement(_steam_id){
	
	// Logic for runKey
	if (runKey == 1 and moveSpeed >= 5) then moveSpeed = 10
	if (runKey == 0 and moveSpeed == 10) then moveSpeed = 5
	
	// Logic to apply movement
	var _move_x = (rightKey - leftKey) * moveSpeed;
	var _move_y = (downKey - upKey) * moveSpeed;
	
	if (_move_x != 0 || _move_y != 0) {
		var _b = buffer_create(13, buffer_fixed, 1);
		buffer_write(_b, buffer_u8, NETWORK_PACKETS.MOVE_PLAYER);
		buffer_write(_b, buffer_s16, _move_x);
		buffer_write(_b, buffer_s16, _move_y);
		buffer_write(_b, buffer_u64, _steam_id); 
		var _lobby_owner = steam_lobby_get_owner_id();
		steam_net_packet_send(_lobby_owner, _b)
		buffer_delete(_b);
	}
	
	// Logic for getting hit by bullet
	if currentCooldown > 0 then --currentCooldown
	if moveSpeed < 5 then moveSpeed = moveSpeed*1.05
	
}