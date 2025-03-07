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
	preload("res://main/contents_window/file_browser.tscn"),
	preload("res://main/contents_window/video_player.tscn"),
	preload("res://main/contents_window/rotating_banana.tscn"),
	preload("res://main/component/shooting_game.tscn"),
	preload("res://main/contents_window/stock_trading.tscn"),
	preload("res://main/contents_window/text_field.tscn"),
	preload("res://main/contents_window/dynamic_text_editor.tscn"),
	preload("res://main/contents_window/shapes.tscn"),
	preload("res://main/contents_window/settings.tscn"),
	preload("res://main/contents_window/system_information.tscn"),
]



var dropdown = preload("res://main/instances_ui/dropdown_desktop.tscn")
var file_dropdown = preload("res://main/instances_ui/file_browser_dropdown.tscn")

var appname = [
	"Text Editor",
	"Pie Clicker",
	"File Browser",
	"Video Player",
	"Rotating Banana",
	"Shooting Game",
	"Stock Trading",
	"Text field",
	"Dynamic Text Editor",
	"Shapes",
	"Settings",
	"System Information"
]

var text_data = preload("res://main/appdata/text_data.tres")
var focused_window = null

var appicon = [
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/pie_clicker/icon.png"),
	preload("res://art/icons/folder.png"),
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/rotating banana/icon.png"),
	preload("res://art/app_art/shooting_game/icon.png"),
	preload("res://art/app_art/stock_trading/icon.png"),
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/shapes/icon.png"),
	preload("res://art/icons/settings.png"),
	preload("res://art/app_art/text editor/icon.png"),
]


var config = [
	["t_Toggle", true],
	["t_Toggle1", false],
	["t_Toggle2", true],
	["d_dropdown1", "item1","item2", "item3"],
	
	["separator"],
	["b_button", preload("res://art/icons/settings.png")],
	["s_Slider", 0.5,0,1],
	["s_Slider1", 50,0,100],
	["t_Toggle2", true],
	["separator"],
	["d_dropdown", "item1","item2"],
	["d_dropdown1", "item1","item2", "item3"],
	["d_dropdown1", "item1","item2", "item3"],
	["d_dropdown1", "item1","item2", "item3"],
	["d_dropdown1", "item1","item2", "item3"],
	["b_button1", preload("res://art/icons/settings.png")],
	
	["t_Toggle3", false],
	["x_textfield", "Textfield example"],
	["x_textfield1", "enter text"],

]
var filesystem = preload("res://main/component/filesystem.tscn")

func sfx(sfx = preload("res://sfx/click_light.wav"), vol = 0, pt = 0):
	var inst = preload("res://main/component/sfx.tscn").instance()
	inst.stream = sfx
	inst.pitch_scale = pt
	inst.volume_db = vol
	add_child(inst)

func _ready() -> void:
	var filesystem_inst = filesystem.instance()
	add_child(filesystem_inst)
	filesystem = filesystem_inst

func make_dropdown(what_dropdown = preload("res://main/instances_ui/dropdown_desktop.tscn"), pos_offset = Vector2.ZERO):
	var dropdown_inst = what_dropdown.instance()
	dropdown_inst.offset = pos_offset
	dropdown_inst.rect_position = get_tree().get_root().get_mouse_position() + pos_offset
	global.main_scene.add_child(dropdown_inst)

func make_dropdown_data(what_dropdown = preload("res://main/instances_ui/dropdown_desktop.tscn"), buttons = [], icons = []):
	var dropdown_inst = what_dropdown.instance()
	dropdown_inst.buttons = buttons
	dropdown_inst.icons = icons
	dropdown_inst.rect_position = get_tree().get_root().get_mouse_position() 
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
	
