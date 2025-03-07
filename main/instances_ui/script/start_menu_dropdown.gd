extends dropdown

func _init() -> void:
	
	buttons = []
	icons = []
	
#	buttons.append("Go back")
#	buttons.append("")
#	icons.append(null)
#	icons.append(null)
	
	for i in global.appname:
		buttons.append(i)
	for i in global.appicon:
		icons.append(i)

func _ready() -> void:
	$Label.set_as_toplevel(true)
	$Label.rect_position = rect_position + Vector2(3, -10)

func _physics_process(delta: float) -> void:
	if hovered:
		if Input.is_action_just_pressed("CLICK"):
			if hovered_text == "Go back":
				global.make_dropdown(global.dropdown, Vector2(-20,-0))
			else:
				for i in range(buttons.size()):
					if buttons[i] == hovered_text:
						global.make_window(global.appname[i],global.apps[i ],global.appicon[i ])
					
			quit = true
