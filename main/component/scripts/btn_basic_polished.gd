extends btn_basic
class_name btn_polished

export var unhover_color = Color.black
export var unhover_color_element = Color.white
export var unhover_self_color = Color.white

export var hover_self_color = Color.white
export var hover_color = Color.white
export var hover_color_element = Color.black

onready var children = get_children()

func _ready() -> void:
	children.pop_front()

func _physics_process(delta: float) -> void:
	if hovered:
		self_modulate = self_modulate.linear_interpolate(hover_self_color,delta * 15)
		for i in children:
			i.modulate = i.modulate.linear_interpolate(hover_color_element,delta * 15)
		$ColorRect.modulate = $ColorRect.modulate.linear_interpolate(hover_color,delta * 15)
	else:
		self_modulate = self_modulate.linear_interpolate(unhover_self_color,delta * 15)
		for i in children:
			i.modulate = i.modulate.linear_interpolate(unhover_color_element,delta * 15)
		$ColorRect.modulate = $ColorRect.modulate.linear_interpolate(unhover_color,delta * 15)

func _on_btn_basic_polished_mouse_entered() -> void:
	hovered = true


func _on_btn_basic_polished_mouse_exited() -> void:
	hovered = false
