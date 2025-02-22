extends Control

var open = false
onready var buttons = [$container/h_container/btn, $container/h_container/btn2, $container/h_container/btn3, $container/h_container/btn4, $container/h_container/btn5, $container/h_container/btn6, $container/h_container/btn7]

func _input(event: InputEvent) -> void:
	for i in buttons:
		if i.is_clicked():
			global.make_window("")

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
	
