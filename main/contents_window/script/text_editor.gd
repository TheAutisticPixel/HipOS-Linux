extends Control

func _physics_process(delta: float) -> void:
	$TextEdit.rect_size = rect_size + Vector2.ONE * 15
	$Label.rect_size.x = rect_size.x 
