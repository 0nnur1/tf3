const MAX_PITCH: float = 85.0

## Returns a new rotation Vector3 rotated by [param deg] on the Y-axis.
func get_turn_y(current_rotation: Vector3, deg: float, delta: float) -> Vector3:
	current_rotation.y += deg_to_rad(deg*delta)
	return current_rotation

## Returns a new rotation Vector3 rotated by [param deg] on the X-axis. 
## - optionally clamped between -[param limit] and [param limit].
func get_turn_x(current_rotation: Vector3, deg: float, delta: float, do_limit: bool = true, limit: float = MAX_PITCH) -> Vector3:
	current_rotation.x += deg_to_rad(deg*delta)
	
	if do_limit:
		var limit_rad := deg_to_rad(limit)
		current_rotation.x = clamp(current_rotation.x, -limit_rad, limit_rad)
		
	return current_rotation
