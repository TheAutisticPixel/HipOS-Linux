extends Node

var window = preload("res://main/component/window.tscn")
var main_scene = null
var taskbar_scene = null
var notif_scene = null

var windows = []

var apps = [
	preload("res://main/contents_window/text_editor.tscn"),
	preload("res://main/contents_window/pie_clicker.tscn"),
	preload("res://main/contents_window/video_player.tscn"),
	preload("res://main/contents_window/system_information.tscn")
]
var appname = [
	"Text Editor",
	"Pie Clicker",
	"Video Player",
	"System Information"
]

var appicon = [
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/pie_clicker/icon.png"),
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/text editor/icon.png"),
	
]

func make_window(window_name = "Text editor",content = preload("res://main/contents_window/text_editor.tscn"), icon = preload("res://art/app_art/text editor/icon.png")):
	var window_inst = window.instance()
	window_inst.window_name = window_name
	window_inst.window_icon = icon
	if content != null:
		var content_inst = content.instance()
		window_inst.get_node("container").add_child(content_inst)
		content_inst.show_behind_parent = true
		window_inst.content = content_inst
	main_scene.window_container.add_child(window_inst)
	windows.append(window_inst)
	
	taskbar_scene.refresh_windows()

func kill_window(whos_calling_to_get_executed_hmm = null):
			
	windows[whos_calling_to_get_executed_hmm].queue_free()
	windows.pop_at(whos_calling_to_get_executed_hmm)

func make_notif(text = "test text lmfao", icon = null, color = Color.white):
	notif_scene.make_notif(text,icon,color)
	
func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("FULLSCREEN"):
		OS.window_fullscreen = !OS.window_fullscreen
	
