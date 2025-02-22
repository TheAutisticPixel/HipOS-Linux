extends Control

onready var starting_pos = rect_position
onready var starting_size = $container.rect_size

onready var window_size = starting_size
onready var window_pos = starting_pos

var starting_mouse_pos = Vector2.ZERO
var starting_window_pos = rect_position

var hovered = false
var fullscreen = false
var minimized = true

var maximized_window_pos = Vector2(0,12)

var window_name = "Text editor"
var content = null

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("CLICK"):
		if hovered:
			for i in get_tree().get_nodes_in_group("window"):
				i.show_on_top = false
			show_on_top = true
		
	if Input.is_action_pressed("SCROLL_DOWN"):
		window_size += Vector2.ONE * 5
	if Input.is_action_pressed("SCROLL_UP"):
		
		window_size -= Vector2.ONE * 5
		
		
func _ready() -> void:
	$container.rect_size = Vector2.ZERO
	rect_position *= 2.5

func _physics_process(delta: float) -> void:
	$window_name/Label.text = window_name
	
	$container/ColorRect2.rect_size.y /= 1.2
	$control.rect_position.x = ($container.rect_size.x - $control.rect_size.x)
	
	$container.rect_size += (window_size - $container.rect_size) * 0.2
	rect_position += (window_pos - rect_position) * 0.2
	
	if content != null:
		content.rect_size = $container.rect_size
		
	
		
	if show_on_top:
		$container.self_modulate = $container.self_modulate.linear_interpolate(Color.white,delta * 15)
	else:
		$container.self_modulate = $container.self_modulate.linear_interpolate(Color.darkgray,delta * 15)
	pan()
	
var dragging := false

func pan():
	if $control/hover_size.is_clicking():
		if Input.is_action_just_pressed("CLICK"):
			dragging = true
			starting_mouse_pos = get_global_mouse_position()
			starting_window_pos = rect_position

		if Input.is_action_pressed("CLICK") and dragging:
			var mouse_delta = get_global_mouse_position() - starting_mouse_pos
			rect_position = starting_window_pos + mouse_delta
			window_pos = rect_position
			
		if Input.is_action_just_released("CLICK"):
			dragging = false
			
			if get_global_mouse_position().x < 10:
				window_pos = maximized_window_pos
			

func fullscreen():
	if fullscreen == false:
		window_pos = maximized_window_pos
		window_size = Vector2(640,360)
	else:
		window_pos = starting_pos
		window_size = starting_size
	fullscreen = !fullscreen
	
func minimize():
	window_pos.y = 380
	window_pos.x *= 2
	window_size.y = -10000
	window_size.x /= 2

func _on_Button_pressed() -> void:
	queue_free()


func _on_container_mouse_entered() -> void:
	hovered = true

func _on_container_mouse_exited() -> void:
	hovered = false

func _on_Button3_pressed() -> void:
	fullscreen()


func _on_Button2_pressed() -> void:
	minimize()
