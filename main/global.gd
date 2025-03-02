extends Node

var window = preload("res://main/component/window.tscn")
var main_scene = null
var taskbar_scene = null
var notif_scene = null

var windows = []

var money = 0

var apps = [
	preload("res://main/contents_window/text_editor.tscn"),
	preload("res://main/contents_window/pie_clicker.tscn"),
	preload("res://main/contents_window/video_player.tscn"),
	preload("res://main/component/shooting_game.tscn"),
	preload("res://main/contents_window/stock_trading.tscn"),
	preload("res://main/contents_window/system_information.tscn")
]

var dropdown = preload("res://main/instances_ui/dropdown_desktop.tscn")

var appname = [
	"Text Editor",
	"Pie Clicker",
	"Video Player",
	"Shooting Game",
	"Stock Trading",
	"System Information"
]

var text_data = preload("res://main/appdata/text_data.tres")
var focused_window = null

var appicon = [
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/pie_clicker/icon.png"),
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/shooting_game/icon.png"),
	preload("res://art/app_art/stock_trading/icon.png"),
	preload("res://art/app_art/text editor/icon.png"),
	
]

func make_dropdown(what_dropdown = preload("res://main/instances_ui/dropdown_desktop.tscn"), pos_offset = Vector2.ZERO):
	var dropdown_inst = what_dropdown.instance()
	dropdown_inst.rect_position = get_tree().get_root().get_mouse_position() + pos_offset
	global.main_scene.add_child(dropdown_inst)
	

var data_path = "user://"

#func store_data(what_data = "", resource = preload("res://main/appdata/text_data.tres")):
#	if what_data != "":
#		var path = str(data_path,"",what_data, ".tres")
#		ResourceSaver.save(path, resource)
#		var result = ResourceLoader.load(path)
#		global.make_notif(str("Saved data to: ", path, " Result: ", result ), preload("res://art/app_art/text editor/icon.png"))
#	else:
#		global.make_notif("Inputted a nonexistant variable for data storing")
#
#func load_data(what_data = ""):
#	var path = str(data_path,"",what_data, ".tres")
#	var result = ResourceLoader.load(path)
#	global.make_notif(str("Loaded resource: ", result, "from: ", path), preload("res://art/app_art/text editor/icon.png"))
#	return result

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
	
