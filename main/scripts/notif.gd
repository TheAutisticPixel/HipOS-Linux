extends NinePatchRect

var timer = 3


func _ready() -> void:
	$timer.rect_size.y =  rect_size.y - 6
	
	if $sprite.texture != null:
		$text.rect_size.x -= 20
		$text.rect_position.x += 20

var pan_pos = Vector2.ZERO
var last_ms_pos = Vector2.ZERO

var drop = false

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("RIGHT_CLICK"):
		pan_pos.x = rect_position.x
		last_ms_pos.x = get_global_mouse_position().x
	
	if Input.is_action_pressed("RIGHT_CLICK"):
		var mouse_delta = get_global_mouse_position().x - last_ms_pos.x
		rect_position.x = pan_pos.x + mouse_delta
		
	if Input.is_action_just_released("RIGHT_CLICK"):
	
		if rect_position.x < pan_pos.x - 25:
			timer = 0.1
		
	if drop:
		rect_position.x -= 15
		rect_position.y += 15
	else:
		$timer.value = timer
		rect_size.y += ((23 + $text.rect_size.y) - rect_size.y) * 0.2
		$btn_basic_polished.rect_size.y = rect_size.y - 8
		timer -= delta
		
		rect_size.x += (211 - rect_size.x) * 0.2
		rect_position.x += (411 - rect_position.x) * 0.2
	
	if timer < 0 or $btn_basic_polished.is_clicked():
		get_parent().kill(get_index())
