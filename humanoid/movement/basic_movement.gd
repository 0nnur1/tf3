## Returns a movement velocity vector based on a pre-rotated direction.
## [param move_dir] should be a normalized Vector3 (already rotated by the camera/basis).
func get_move(move_dir: Vector3, speed: float = 1.0) -> Vector3:
	return move_dir * speed


## Returns a new Y-velocity for jumping.
## - If [param retain] is true, adds a percentage of [param current_y_vel] to the jump.
## - Uses max(0, velocity) to prevent "gravity debt" from killing the jump height.
func get_jump(current_y_vel: float, jump_velocity: float, retain: bool = true, retention_pct: float = 10.0) -> float:
	if retain:
		return jump_velocity + (max(0.0, current_y_vel) * (retention_pct / 100.0))
	return jump_velocity


func get_wall_hop(
	velocity: Vector3,
	wall: KinematicCollision3D,
	move_dir: Vector3,
	jump_force: float,
	push_away_force: float = 5.0,
	input_boost: float = 1.0
) -> Vector3:

	var normal := wall.get_normal()

	# 1. Remove velocity into wall
	var into_wall := velocity.dot(normal)
	if into_wall < 0.0:
		velocity -= normal * into_wall

	# 2. Push away from wall (horizontal only)
	var kick_dir := Vector3(normal.x, 0.0, normal.z)
	if kick_dir.length() > 0.001:
		kick_dir = kick_dir.normalized()
		velocity += kick_dir * push_away_force

	# 3. Jump (vertical control)
	velocity.y = get_jump(velocity.y, jump_force)

	# 4. Input steering (only horizontal influence)
	var input := move_dir * input_boost
	input.y = 0.0
	velocity += input

	return velocity

## Applies slide behavior: keeps momentum, adds a small boost, and reduces speed over time.
func get_slide(
	velocity: Vector3,
	floor_normal: Vector3,
	move_dir: Vector3,
	boost: float,
	friction: float,
	gravity: float,
	delta: float
) -> Vector3:

	# 1. Horizontal velocity 
	var horizontal := Vector3(velocity.x, 0.0, velocity.z)

	# 2. Entry / steering boost 
	if move_dir.length() > 0.0:
		horizontal += move_dir.normalized() * boost

	# 3. Downhill direction from surface normal 
	var downhill := Vector3(floor_normal.x, 0.0, floor_normal.z)

	if downhill.length() > 0.001:
		downhill = downhill.normalized()

		# 3.1. slope strength: 0 on flat, increases as surface tilts
		var slope_strength: float = clamp(1.0 - floor_normal.y, 0.0, 1.0)

		# 3.2. apply gravity along slope
		horizontal += downhill * gravity * slope_strength * delta

	# 4. Friction (smooth decay)
	horizontal = horizontal.lerp(Vector3.ZERO, friction * delta)

	# 5. Write back 
	velocity.x = horizontal.x
	velocity.z = horizontal.z

	return velocity
