extends Node2D

var count = 0
export var distance = 1.1
export var speed = 7.5
export var amount = 32

export var size = 32

var sizes = []
export var stop_generating = false


func _draw() -> void:
	for i in sizes:
#		draw_arc(Vector2.ZERO, i * size * 2, -PI, PI, 360, Color.black, size * 2
		var z = size
		z = clamp(z,0,i * size)
		
		draw_arc(Vector2.ZERO, i * z * 2, -PI, PI, 360 / 2, self_modulate, z )
func _physics_process(delta: float) -> void:
	update()
	
	if sizes.size() < amount:
		
		count -= delta * speed * distance
		
		if count < 0:
			if not stop_generating:
				sizes.append(0)
			count = 1 
			
	if sizes.size() >= amount:
		sizes.remove(0)
	
	for i in range(sizes.size()):
		sizes[i] += delta * speed

func stop_generating():
	stop_generating = true
	sizes = []
	for i in range(2):
		sizes.append(i + i * distance + speed)

