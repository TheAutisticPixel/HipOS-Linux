extends dropdown

var directory = null


func _init() -> void:
	buttons = []
	icons = []
	if directory == null:
		directory = global.filesystem.get_children()
		
	for i in directory:
		buttons.append(str(i))
		
		
func _physics_process(delta: float) -> void:
	pass
#	if hovered:
#		if Input.is_action_just_pressed("CLICK"):
#			if hovered_text != "":
#				global.make_dropdown_data(global.file_dropdown,buttons = )
