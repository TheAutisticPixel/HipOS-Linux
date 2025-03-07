extends Sprite

var holograms = []

onready var holoinst = $holo.duplicate()
var offsets = []
var sizes = []

var count = 0

func _ready() -> void:
	$holo.queue_free()
	for i in range(30):
		var holo_duplicate = holoinst.duplicate()
		var off = Vector2(rand_range(-355,455),rand_range(-230,190))
		holo_duplicate.rect_global_position = Vector2.ZERO
		offsets.append(off)
		holo_duplicate.rect_size = Vector2(rand_range(1,66),rand_range(1,66))
		holo_duplicate.get_node("sprite").position.y += rand_range(-55,0)
		sizes.append(holo_duplicate.rect_size)
		holo_duplicate.get_node("stripe").modulate = Color(1,1,1,rand_range(-0.3,0.6))
		
		if rand_range(0,1) > 0.5:
			holo_duplicate.get_node("sprite").scale.y = -1
		add_child(holo_duplicate)
		holograms.append(holo_duplicate)

func _physics_process(delta: float) -> void:
	if global.main_scene.current_state == global.main_scene.states.main:
		count += delta / 20
		
		if global.main_scene.shutdown_true:
			$Viewport/Camera.translation.z += delta * 2
			get_parent().modulate = get_parent().modulate.linear_interpolate(Color(0.4,0.4,0.4,1),delta * 0.5)
			
		
		for i in range(holograms.size()):
			var p = holograms[i]
			p.modulate = p.modulate.linear_interpolate(Color8(28,44,87,p.rect_position.length()),delta * 3)
			p.rect_position = p.rect_position.linear_interpolate(Vector2(sin(i + (count * offsets[i].length() / 55)),cos(i + (count * offsets[i].length() / 255))) * offsets[i].length(),delta * 1)
			if p.rect_position.distance_squared_to(get_local_mouse_position()) < 11000:
				p.modulate = p.modulate.linear_interpolate(Color.blue,delta * 23)
		


