extends btn_polished

var on = false

func _gui_input(event: InputEvent) -> void:
	if is_clicked():
		on = !on

func _physics_process(delta: float) -> void:
	
	if on:
		$toggle_visual/toggle_rect/rect.rect_position.x += (18 - $toggle_visual/toggle_rect/rect.rect_position.x) * 0.4
	else:
		$toggle_visual/toggle_rect/rect.rect_position.x += (2 - $toggle_visual/toggle_rect/rect.rect_position.x) * 0.4
	
	
