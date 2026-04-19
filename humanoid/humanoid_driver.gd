extends Node

const movement_handler = preload("res://humanoid/movement/movement_controller.gd")
const camera_handler = preload("res://humanoid/camera/camera_controller.gd")

var movement = movement_handler.new()
var camera = camera_handler.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
