extends dropdown

func _physics_process(delta: float) -> void:
	
	if hovered:
		if Input.is_action_just_pressed("CLICK"):
			if hovered_text == "Minimize all programs":
				for i in global.windows:
					i.minimize()
			if hovered_text == "Start menu":
				global.make_dropdown(preload("res://main/instances_ui/start_menu_dropdown.tscn"),  -get_local_mouse_position())
			if hovered_text == "Text editor":
				global.make_window(global.appname[0], global.apps[0],global.appicon[0])
			if hovered_text == "Pie Clicker":
				global.make_window(global.appname[1], global.apps[1],global.appicon[1])
			if hovered_text == "Stock Trading":
				global.make_window(global.appname[4], global.apps[4],global.appicon[4])
			if hovered_text == "Settings":
				global.make_window("Settings", preload("res://main/contents_window/settings.tscn"), preload("res://art/icons/settings.png"))
			if hovered_text == "Shut down computer":
				global.main_scene.shutdown()
			quit = true
