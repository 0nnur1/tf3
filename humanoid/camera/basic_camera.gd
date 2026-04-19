const MAX_PITCH: float = 85.0

## Returns a new rotation Vector3 rotated by [param deg] on the Y-axis.
func get_turn_y(current_rotation: Vector3, deg: float) -> Vector3:
	var new_rotation = current_rotation
	new_rotation.y += deg_to_rad(deg)
	return new_rotation

## Returns a new rotation Vector3 rotated by [param deg] on the X-axis, 
## - optionally clamped between -[param limit] and [param limit].
func get_turn_x(current_rotation: Vector3, deg: float, do_limit: bool = true, limit: float = MAX_PITCH) -> Vector3:
	var new_rotation = current_rotation
	new_rotation.x += deg_to_rad(deg)
	
	if do_limit:
		var limit_rad = deg_to_rad(limit)
		new_rotation.x = clamp(new_rotation.x, -limit_rad, limit_rad)
		
	return new_rotation
