extends RefCounted

const Basic = preload("res://humanoid/movement/basic_movement.gd")
const Check = preload("res://humanoid/movement/movement_check.gd")

var basic = Basic.new()
var check = Check.new()

func update() -> void:
	pass
