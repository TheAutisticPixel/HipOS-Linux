extends dropdown

func _init() -> void:
	
	
	buttons = []
	icons = []
	
	buttons.append("Go back")
	buttons.append("")
	icons.append(null)
	icons.append(null)
	
	for i in global.appname:
		buttons.append(i)
	for i in global.appicon:
		icons.append(i)
		
	
func _physics_process(delta: float) -> void:
	if hovered:
		if Input.is_action_just_pressed("CLICK"):
			if hovered_text == "Go back":
				global.make_dropdown(global.dropdown, Vector2(-20,-0))
			else:
				for i in range(buttons.size()):
					if buttons[i] == hovered_text:
						global.make_window(global.appname[i - 2],global.apps[i - 2],global.appicon[i - 2])
					
			quit = true
