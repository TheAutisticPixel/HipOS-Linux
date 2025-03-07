extends Control

onready var letter = $text.duplicate()

var texts = []
var cursor_index = 0

var symbols = [
	["Space", " "],
	["CapsLock", ""],
	["Alt", ""],
	["Shift", ""],
	["Control", ""],
	["Enter", ""],
	["Meta+", ""],
	["Tab", ""],
	["Left", ""],
	["Right", ""],
	["Up", ""],
	["Down", ""],
	["Backspace", ""],
	["Period", "."],
	["Comma", ","],
]	

var caps = false
var scale = false

func _ready() -> void:
	$text.queue_free()
	
func _input(event):
	if event is InputEventKey and event.pressed:
		var key_name = OS.get_scancode_string(event.scancode)
		var backspace = false
		
		if key_name == "Tab":
			scale = !scale
		
		if key_name == "CapsLock":
			caps = !caps
		
		if key_name == "BackSpace":
			backspace = true
			
		if key_name == "Left":
			cursor_index -= 1

		if key_name == "Right":
			cursor_index += 1

		for i in symbols:
			if i[0] == key_name:
				key_name = i[1]
		
		if caps == false:
			key_name = key_name.to_lower()
				
		if key_name != "":
			add(key_name)
		
		if backspace:
			remove(cursor_index)
			remove(cursor_index)
			
	if Input.is_action_pressed("CLICK"):
		for i in range(texts.size()):
			if get_local_mouse_position().x > texts[i].rect_position.x and get_local_mouse_position().x < texts[i].margin_right:
				cursor_index = i
			if get_local_mouse_position().x > texts.back().margin_right:
				cursor_index = texts.size() 
	

func add(ltr = ""):
	var letter_inst = letter.duplicate()
	letter_inst.text = ltr
	texts.insert(cursor_index, letter_inst)
	letter_inst.rect_position.x = cursor_index * 5
	letter_inst.rect_position.x += 10
	add_child(letter_inst)
	cursor_index += 1

func remove(index = 0):
	if texts != []:
		var letter_to_remove = texts[index - 1]
		texts.pop_at(index - 1)
		letter_to_remove.queue_free()
		if cursor_index > texts.size() - 1:
			cursor_index -= 1
		else:
			cursor_index -= 1
	
func _physics_process(delta: float) -> void:
	
	if scale:
		rect_scale = rect_scale.linear_interpolate(Vector2.ONE * 2,delta * 15)
	else:
		rect_scale = rect_scale.linear_interpolate(Vector2.ONE,delta * 15)
	
	if texts != []:
		animate(delta)
		
		if is_instance_valid(texts[cursor_index - 1]):
			$cursor.rect_position.x += ((texts[cursor_index - 1].rect_position.x + 5) - $cursor.rect_position.x) * 0.5
	else:
		$cursor.rect_position.x /= 1.1
		
	$cursor.modulate = Color(1,1,1,abs(sin(OS.get_ticks_msec() * delta * 0.5) * 1))

func animate(delta):
	for i in range(texts.size()):
		if is_instance_valid(texts[i]):
			texts[i].rect_position.x += (i * 5 - texts[i].rect_position.x) * 0.5
	
