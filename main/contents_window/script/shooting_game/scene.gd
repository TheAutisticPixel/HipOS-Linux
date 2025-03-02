extends Node2D

var ms_pos = Vector2.ZERO

func _physics_process(delta: float) -> void:
	$cam.position += ($player.position - $cam.position) * 0.2
	ms_pos = (get_parent().get_parent().get_local_mouse_position() + $cam.position) - get_parent().size / 2
	$cursor.position = ms_pos
