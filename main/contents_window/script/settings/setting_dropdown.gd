extends btn_polished

var open = false

func _gui_input(event: InputEvent) -> void:
	if is_clicked():
		open = !open

func _physics_process(delta: float) -> void:
	if open:
		rect_size.y = 100
	else:
		rect_size.y = 13
		
	$dropdown_visual/rect.rect_size.y = rect_size.y - 1
		
