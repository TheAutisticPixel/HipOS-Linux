extends Control

var focused = true

func _ready() -> void:
	get_parent().get_parent().resizable = false
	get_parent().get_parent().fullscreenable = false
	get_parent().get_parent().hide_cursor = true

func _physics_process(delta: float) -> void:
	if get_parent().get_parent().focused:
		$game/scene/player.input = true
	else:
		$game/scene/player.input = false
