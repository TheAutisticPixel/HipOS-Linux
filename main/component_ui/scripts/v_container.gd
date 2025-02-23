extends Node2D

export var lerp_speed = 1.0

var active = true
onready var rects = get_children()
export var spacing = 5

func refresh_rects():
	rects = get_children()

func _physics_process(delta: float) -> void:
	if active:
		if rects != []:
			rects.front().rect_position.y += (0 - rects.front().rect_position.y) * lerp_speed
		for i in range(rects.size() - 1):
			rects[i + 1].rect_position.y += ((rects[i].rect_position.y + (rects[i].rect_size.y + spacing)) - rects[i + 1].rect_position.y) * lerp_speed

func kill(index = 0):
	var rect_to_kill = rects[index]
	rects.pop_at(index)
	rect_to_kill.queue_free()
	
