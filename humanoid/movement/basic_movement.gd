

##returns [param input] after going through basic calculation
func get_move(body: CharacterBody3D, input: Vector2, use_speed: bool = false, speed: float=0) -> Vector3:
	var dir = body.global_transform.basis * Vector3(input.x, 0, input.y)
	if use_speed:
		dir *= speed
	return dir
	
	



## Returns a new Vector3 with the Y component set to [param jump_velocity] 
## - optionally retains [param retention]% of current Y velocity.
func get_jump(current_velocity: Vector3, jump_velocity: float, retain: bool = true, retention: float = 10.0) -> Vector3:
	var new_velocity = current_velocity
	
	if retain:
		new_velocity.y = jump_velocity + (current_velocity.y * (retention / 100.0))
	else:
		new_velocity.y = jump_velocity
		
	return new_velocity
	
