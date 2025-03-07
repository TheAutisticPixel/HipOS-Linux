extends btn_polished

var value = 50
var min_value = 0
var max_value = 100

func _ready() -> void:
	$slider_visual/slide.value = value
	$slider_visual/slide.max_value = max_value
	$slider_visual/slide.min_value = min_value
	
	
func _physics_process(delta: float) -> void:
	if is_clicking():
		$slider_visual/slide.value =  ($slider_visual/slide.get_local_mouse_position().x / $slider_visual/slide.rect_size.x) * max_value
