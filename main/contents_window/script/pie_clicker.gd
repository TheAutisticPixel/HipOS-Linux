extends Control

var hovered = false
var clicks = 0

var vel = 0

func _physics_process(delta: float) -> void:
	
	$text2.rect_position.y += vel * (delta * 2)
	vel += (44 - $text2.rect_position.y) * 30
	vel /= 1.5
	
	if hovered:
		if Input.is_action_pressed("CLICK"):
			$Pie/Sprite.scale -= Vector2.ONE * delta * 3
			vel -= 123
			
		if Input.is_action_just_released("CLICK"):
			clicks += 1
			vel += 423
			$text2.text = str(clicks)
			
			$Pie/Sprite.scale += Vector2.ONE * delta * 16
		$Pie/Sprite.scale = $Pie/Sprite.scale.linear_interpolate(Vector2.ONE * 1.2,delta * 15) 
	else:
		$Pie/Sprite.scale = $Pie/Sprite.scale.linear_interpolate(Vector2.ONE,delta * 15) 
	

func _on_Pie_mouse_entered() -> void:
	hovered = true

func _on_Pie_mouse_exited() -> void:
	hovered = false
