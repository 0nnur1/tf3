func wall_hop_check(body: CharacterBody3D, steepness: float = 70) -> bool:
	if body.is_on_floor(): 
		return false
	
	# check every object touched this frame
	for i in body.get_slide_collision_count():
		var collision := body.get_slide_collision(i)
		var normal := collision.get_normal()
		
		var surface_angle := rad_to_deg(acos(abs(normal.y)))
		if surface_angle > steepness:
			return true
			
	return false
