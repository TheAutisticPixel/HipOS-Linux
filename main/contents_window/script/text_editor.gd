extends Control

var scroll = 0

var last_scroll = 0
var scroll_time = 0

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("SCROLL_DOWN"):
		scroll += 5
		scroll_time = 1
		
	if Input.is_action_just_pressed("SCROLL_UP"):
		scroll -= 5
		scroll_time = 1
		
func _physics_process(delta: float) -> void:
	scroll = clamp(scroll, 0 ,$TextEdit.get_line_count())
	
	if scroll_time > 0:
		scroll_time -= delta
		$TextEdit.scroll_vertical += (scroll - $TextEdit.scroll_vertical) * 0.1
	else:
		scroll = $TextEdit.scroll_vertical
	
	$TextEdit.rect_size = rect_size - Vector2(6,20)
	$Label.rect_size.x = rect_size.x 


func _on_TextEdit_text_changed() -> void:
	scroll_time = 1
