extends Node2D

var lerp_speed = 0

var active = true
onready var rects = get_children()
export var spacing = 5

func refresh():
	rects = get_children()
	
	for i in rects:
		i.rect_position.x = 0
		 
	rects.pop_front()
	
func _physics_process(delta: float) -> void:

		
		
	if active:
		if rects != []:
			for i in range(rects.size() - 1):
				if is_instance_valid(rects[i]):
					rects[i + 1].rect_position.x += ((rects[i].rect_position.x + (rects[i].rect_size.x + spacing)) - rects[i + 1].rect_position.x) * 0.2
