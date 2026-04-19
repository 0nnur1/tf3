extends Resource
class_name player_settings

const SAVE_LOCATION = "user://settings.tres"

var _look_sensitivity: float = 0.1
@export var look_sensitivity: float:
	get: return _look_sensitivity
	set(value):
		_look_sensitivity = value
		save()

var _jump_velocity: float = 6
@export var jump_velocity: float:
	get: return _jump_velocity
	set(value):
		_jump_velocity = value
		save()

var _walk_speed: float = 7
@export var walk_speed: float:
	get: return _walk_speed
	set(value):
		_walk_speed = value
		save()

var _sprint_speed: float = 8.5
@export var sprint_speed: float:
	get: return _sprint_speed
	set(value):
		_sprint_speed = value
		save()

static func load_or_create() -> player_settings:
	if FileAccess.file_exists(SAVE_LOCATION):
		var res = ResourceLoader.load(SAVE_LOCATION)
		if res:
			return res
	
	var new_settings = player_settings.new()
	new_settings.save()
	return new_settings

func save():
	ResourceSaver.save(self, SAVE_LOCATION)
