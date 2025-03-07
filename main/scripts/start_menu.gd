extends Control

var open = false
onready var buttons = []
onready var btn_inst = $container/btn.duplicate()
var start_menu = preload("res://main/instances_ui/tiled_start.tscn")
var start_menu_instance = null

func _ready() -> void:
	$container/btn.queue_free()
	
	for i in range(global.apps.size()):
		var btn_instance = btn_inst.duplicate()
		btn_instance.get_node("text").text = global.appname[i]
		$container/h_container.add_child(btn_instance)
		buttons.append(btn_instance)
		
	$container/h_container.refresh_rects()
	
	var start_menu_inst = start_menu.instance()
	start_menu_instance = start_menu_inst

func _input(event: InputEvent) -> void:
	for i in range(buttons.size()):
		if buttons[i].is_clicked():
			global.make_window(global.appname[i], global.apps[i], global.appicon[i])
			global.make_notif("You have started a program!!!", null, Color.white)
			open = false
			
func _physics_process(delta: float) -> void:
	
	if $btn_basic.is_clicked() or Input.is_action_just_pressed("START") and open == false:
		var start_menu_inst = start_menu.instance()
		get_parent().add_child(start_menu_inst)
		open = !open


	$title.rect_position.y = $container.rect_position.y - 30
	
	if open:
		$AudioStreamPlayer.volume_db += (-20 - $AudioStreamPlayer.volume_db) * 0.01
#		$container.rect_size.y += (249 - $container.rect_size.y) * 0.2
#		$container.rect_position.y += (187 - $container.rect_position.y) * 0.2
	else:
		$AudioStreamPlayer.volume_db += (-80 - $AudioStreamPlayer.volume_db) * 0.003
		
		$container.rect_size.y += (135 - $container.rect_size.y) * 0.2
		$container.rect_position.y += (362 - $container.rect_position.y) * 0.2
#
