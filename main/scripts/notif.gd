extends NinePatchRect

var timer = 3

func _ready() -> void:
	$timer.rect_size.y =  rect_size.y - 6
	
	if $sprite.texture != null:
		$text.rect_size.x -= 20
		$text.rect_position.x += 20
	
func _physics_process(delta: float) -> void:
	$timer.value = timer
	rect_size.y += ((23 + $text.rect_size.y) - rect_size.y) * 0.2
	$btn_basic_polished.rect_size.y = rect_size.y - 8
	timer -= delta
	
	
	
	if timer < 0 or $btn_basic_polished.is_clicked():
		get_parent().kill(get_index())
