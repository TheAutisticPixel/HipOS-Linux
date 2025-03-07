extends btn_polished
class_name btn_start

export var spr_offset = Vector2(3,18)
onready var starting_sprite_pos = $Sprite.position

export var dont_move = false

onready var starting_text_pos = $text.rect_position
export var hover_size_add = Vector2.ZERO
export var hover_pos_add = Vector2.ZERO

var spin_speed = 0.05
var just_hovered = false

func _ready() -> void:
	$Sprite.position = Vector2.ONE * 50 * rect_position.y
	
func _input(event: InputEvent) -> void:
	if hovered:
		get_parent().get_parent().hovered = self

func _physics_process(delta: float) -> void:
	if hovered:
		if just_hovered == false:
			global.sfx(preload("res://sfx/click_light.wav"), 1, 1.5)
			just_hovered = true
		rect_size += hover_size_add
		rect_position += hover_pos_add
		$Sprite.position = $Sprite.position.linear_interpolate(starting_sprite_pos,delta * 10)
		$text.rect_position = $text.rect_position.linear_interpolate(starting_text_pos + Vector2(3,0),delta * 10)
	else:
		just_hovered = false
		$Sprite.position = $Sprite.position.linear_interpolate(starting_sprite_pos + spr_offset + Vector2(cos((rect_position.length_squared() + OS.get_ticks_msec()) * delta * spin_speed) * 5, sin((rect_position.length_squared() + OS.get_ticks_msec()) * delta * spin_speed) * 5),delta * 5)
		$text.rect_position = $text.rect_position.linear_interpolate(starting_text_pos ,delta * 10)
	
	if is_click_release():
		get_parent().get_parent().launch(self)
