extends Node2D

onready var mover = $mover.get_children()
var mover_pos = []
var mover_count = 0

var timer = 0

func _ready() -> void:
	for i in range(mover.size()):
		mover_pos.append(mover[i].rect_position)
		mover[i].rect_position = Vector2(-10000,0)
		
func _physics_process(delta: float) -> void:
	if mover_count < mover.size():
		mover_count += delta * 30
		
	for i in range(mover_count):
		if mover_count > mover.size() - 1:
			timer += delta
		if timer < 70:
			mover[i].rect_position = mover[i].rect_position.linear_interpolate(mover_pos[i],delta * 10)
		
	if timer > 130:
		for i in range(mover_count):
			mover[i].rect_position.x *= 1.05
