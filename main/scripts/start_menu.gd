extends Control

var open = false
onready var buttons = []
onready var btn_inst = $container/btn.duplicate()

func _ready() -> void:
	$container/btn.queue_free()
	
	for i in range(global.apps.size()):
		var btn_instance = btn_inst.duplicate()
		btn_instance.get_node("text").text = global.appname[i]
		$container/h_container.add_child(btn_instance)
		buttons.append(btn_instance)
		
	$container/h_container.refresh_rects()
		

func _input(event: InputEvent) -> void:
	for i in range(buttons.size()):
		if buttons[i].is_clicked():
			global.make_window(global.appname[i], global.apps[i], global.appicon[i])
			
			open = false
			
func _physics_process(delta: float) -> void:
	
	if $btn_basic.is_clicked():
		open = !open
	$title.rect_position.y = $container.rect_position.y - 30
	
	if open:
		$container.rect_size.y += (249 - $container.rect_size.y) * 0.2
		$container.rect_position.y += (187 - $container.rect_position.y) * 0.2
	else:
		$container.rect_size.y += (135 - $container.rect_size.y) * 0.2
		$container.rect_position.y += (362 - $container.rect_position.y) * 0.2
	
