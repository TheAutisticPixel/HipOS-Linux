extends btn_basic

func _physics_process(delta: float) -> void:
	if hovered:
		$text.modulate = $text.modulate.linear_interpolate(Color.black,delta * 15)
		$ColorRect.modulate = $ColorRect.modulate.linear_interpolate(Color.white,delta * 15)
		
		rect_size.y += (28 - rect_size.y) * 0.2
	else:
		
		$text.modulate = $text.modulate.linear_interpolate(Color.white,delta * 15)
		$ColorRect.modulate = $ColorRect.modulate.linear_interpolate(Color(0.1, 0.1, 0.1,1),delta * 15)
		
		rect_size.y += (16 - rect_size.y) * 0.2
	
