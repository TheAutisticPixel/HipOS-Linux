extends Node2D

var lerp_speed = 0

var active = true
onready var rects = get_children()
export var spacing = 5

func _physics_process(delta: float) -> void:
	if active:
		for i in range(rects.size() - 1):
			rects[i + 1].rect_position.x += ((rects[i].rect_position.x + (rects[i].rect_size.x + spacing)) - rects[i + 1].rect_position.x) 
