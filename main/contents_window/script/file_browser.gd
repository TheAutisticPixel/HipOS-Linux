extends Control

var last_size = 0

func _physics_process(delta: float) -> void:
	if last_size != get_parent().rect_size.x:
		
		last_size = get_parent().rect_size.x
