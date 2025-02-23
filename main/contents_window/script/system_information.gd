extends Control

func _physics_process(delta: float) -> void:
	$text.rect_size.x = rect_size.x - $text.rect_position.x
