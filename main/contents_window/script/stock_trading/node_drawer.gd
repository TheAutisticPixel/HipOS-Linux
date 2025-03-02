extends Node2D

var bars = []
var offsets = []
onready var dot = $dot.duplicate()

var update_interval = 0.4
onready var spacing = 8 * 2

func _ready() -> void:
	$dot.queue_free()

func _draw() -> void:
	for i in range(bars.size() - 1):
		var barpos = ($center.position.x + (i * spacing))
		var barheight = $center.position.y + offsets[i]
		
		bars[i + 1].position = bars[i + 1].position.move_toward(Vector2(barpos,barheight), 1)
#		bars[i + 1].position.x += (barpos  - bars[i + 1].position.x) * 0.1
		
#		bars[i + 1].position.y += (barheight - bars[i + 1].position.y) * 0.1
		
		draw_line(bars[i].position, bars[i + 1].position,Color.white,1.0)


func _physics_process(delta: float) -> void:
	update()
	
	update_interval -= delta
	if update_interval < 0:
		
		var dot_inst = dot.duplicate()
		var offset = rand_range(-30,30)
		offsets.append(offset)
		var starting_pos = $center.position.x + ((bars.size() - 1) * spacing)
		if bars.size() > 2:
			starting_pos = bars[bars.size() - 1].position.x
		dot_inst.position = $center.position + Vector2(starting_pos , 0)
		bars.append(dot_inst)
		add_child(dot_inst)
		
		update_interval = 0.3
		
	if bars.size() > (42 / 2):
		var node_to_free = bars.front()
		offsets.pop_front()
		bars.pop_front()
		node_to_free.queue_free()
