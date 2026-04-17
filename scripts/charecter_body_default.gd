extends CharacterBody3D

@export var look_sensitivity: float = 0.1
@export var jump_velocity: float = 6
@export var auto_bhop: bool = true
@export var walk_speed: float = 7
@export var sprint_speed: float = 8.5

var wish_dir: Vector3 = Vector3.ZERO

const HEADBOB_MOVE_AMOUNT: float = 0.05
const HEADBOB_FREQUENCY: float = 10
const HEADBOB_SPRINT_MULTIPLIER: float = 1.5
var headbob_time: float = 0


# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	for child in %model.find_children("*", "VisualInstance3D"):
		child.set_layer_mask_value(1, false)
		child.set_layer_mask_value(2, true)

func _process(_delta: float) -> void:
	pass

	var input_dir: Vector2 = Input.get_vector(
		"player_move_left",
		"player_move_right",
		"player_move_forward",
		"player_move_backword"
	)

	wish_dir = (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	wish_dir.y = 0
	wish_dir = wish_dir.normalized()

	if is_on_floor():
		_handle_ground_physics(_delta)
	else:
		_handle_air_physics(_delta)

	move_and_slide()

func _handle_air_physics(_delta: float) -> void:
	self.velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * _delta

func _handle_ground_physics(_delta: float) -> void:
	self.velocity.x = wish_dir.x * (sprint_speed if Input.is_action_pressed("player_sprint") else walk_speed)
	self.velocity.z = wish_dir.z * (sprint_speed if Input.is_action_pressed("player_sprint") else walk_speed)
	if Input.is_action_just_pressed("player_jump"):
		self.velocity.y = jump_velocity

func _headbob_effect(_delta):
	pass

	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # if mouse is uncaptered, capture it when mouse is moved
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED: # rotates chamera if mouse is captured
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * look_sensitivity))
			%Camera3D.rotate_x(deg_to_rad(-event.relative.y * look_sensitivity))
			%Camera3D.rotation.x = clamp(%Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))
