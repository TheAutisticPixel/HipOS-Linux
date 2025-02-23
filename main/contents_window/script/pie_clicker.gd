extends Control

var hovered = false

func _physics_process(delta: float) -> void:
	if hovered:
		if Input.is_action_pressed("CLICK"):
			$Pie/Sprite.scale -= Vector2.ONE * delta * 3
		if Input.is_action_just_released("CLICK"):
			$Pie/Sprite.scale += Vector2.ONE * delta * 16
		$Pie/Sprite.scale = $Pie/Sprite.scale.linear_interpolate(Vector2.ONE * 1.2,delta * 15) 
	else:
		$Pie/Sprite.scale = $Pie/Sprite.scale.linear_interpolate(Vector2.ONE,delta * 15) 



func _on_Pie_mouse_entered() -> void:
	hovered = true

func _on_Pie_mouse_exited() -> void:
	hovered = false
