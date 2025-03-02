extends Control

var scroll = 0

var last_scroll = 0
var scroll_time = 0

var text_index = 0

var data_path = "user://text_data.tres"

var loaded_data = null

func _ready() -> void:
	var loaddata = ResourceLoader.load(data_path)
	if loaddata == null:
		ResourceSaver.save(data_path,preload("res://main/appdata/text_data.tres"))
		loaded_data = ResourceLoader.load(data_path)
	else:
		$TextEdit.text = loaddata.text[text_index]
		$Label.text = loaddata.name[text_index]
		loaded_data = loaddata
		
		
func load_text(index = 0):
	global

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
		$TextEdit.scroll_vertical += (scroll - $TextEdit.scroll_vertical) * 0.2
	else:
		scroll = $TextEdit.scroll_vertical
	
	$TextEdit.rect_size = rect_size - Vector2(6,20)
	$Label.rect_size.x = rect_size.x 


func _on_TextEdit_text_changed() -> void:
	scroll_time = 1
	loaded_data.text[text_index] = $TextEdit.text
	loaded_data.name[text_index] = $Label.text
	ResourceSaver.save(data_path,loaded_data)
