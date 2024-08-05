function get_idx_playerList(_steamID) {
	var _res = -1;
	for (var _i = 0; _i < 4; _i++) {
		if (playerList[_i] != undefined && playerList[_i].steamID == _steamID) {
			_res = _i; 
			break; 
		} 
	}
	return _res; 
}