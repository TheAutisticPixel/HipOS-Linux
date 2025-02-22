extends Node

var window = preload("res://main/component/window.tscn")
var main_scene = null
var taskbar_scene = null

func make_window(window_name = "Text editor",content = preload("res://main/contents_window/text_editor.tscn")):
	var window_inst = window.instance()
	window_inst.window_name = window_name
	if content != null:
		var content_inst = content.instance()
		window_inst.add_child(content_inst)
		content_inst.show_behind_parent = true
		window_inst.content = content_inst
	main_scene.window_container.add_child(window_inst)
	
	taskbar_scene.refresh_windows()
	
func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("FULLSCREEN"):
		OS.window_fullscreen = !OS.window_fullscreen
	
