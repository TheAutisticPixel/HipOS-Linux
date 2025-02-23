extends NinePatchRect
class_name btn_basic

var hovered = false


func _on_btn_basic_mouse_entered() -> void:
	hovered = true

func _on_btn_basic_mouse_exited() -> void:
	hovered = false

func is_clicking():
	if hovered and Input.is_action_pressed("CLICK"):
		return true
	else:
		return false

func is_click_release():
	if hovered and Input.is_action_just_released("CLICK"):
		return true
	else:
		return false
func is_clicked():
	if hovered and Input.is_action_just_pressed("CLICK"):
		return true
	else:
		return false
