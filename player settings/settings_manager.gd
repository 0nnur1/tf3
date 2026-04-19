extends Node

var settings: player_settings

func _ready():
	settings = player_settings.load_or_create()
