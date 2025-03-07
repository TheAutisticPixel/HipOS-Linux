extends Control

onready var starting_pos = rect_position
onready var starting_size = $container.rect_size

var last_windowed_pos = Vector2.ZERO
var last_windowed_size = Vector2.ZERO

onready var window_size = starting_size
onready var window_pos = starting_pos

var starting_mouse_pos = Vector2.ZERO
var starting_window_pos = rect_position
var starting_window_size = Vector2.ZERO

var temporary_size_active = false

var hovered = false
var fullscreen = false
var minimized = false

var maximized_window_pos = Vector2(0,11)
var maximized_window_size = Vector2(640,332)

var window_name = "Text editor"
var window_icon = preload("res://art/app_art/text editor/icon.png")
var content = null

onready var name_node = $top_window/window_name/Label
onready var icon_node = $top_window/window_name/window_icon
onready var control = $hover/control
onready var hover_size = $hover_size

var resizable = true
var fullscreenable = true
var minimizable = true
var hide_cursor = false



var right_size_dragging = false
var left_size_dragging = false
var down_size_dragging = false
var up_size_dragging = false

var last_right_size = 0
var last_down_size = 0

var last_x_pos = 0
var last_y_pos = 0

var focused = true

func _draw() -> void:
	if resizable:
		if get_local_mouse_position().y > 0 and get_local_mouse_position().y < window_size.y:
			if get_local_mouse_position().x > window_size.x - 5 and get_local_mouse_position().x < window_size.x + 5:
				draw_line(Vector2(window_size.x - 5,get_local_mouse_position().y), Vector2(window_size.x + 5,get_local_mouse_position().y), Color.white,5)
				if Input.is_action_just_pressed("CLICK"):
					right_size_dragging = true
					starting_mouse_pos.x = get_global_mouse_position().x
					starting_window_pos.x = window_size.x
					
			if get_local_mouse_position().x > -5 and get_local_mouse_position().x < 5:
				draw_line(Vector2(-5,get_local_mouse_position().y), Vector2(5,get_local_mouse_position().y), Color.white,5)
				if Input.is_action_just_pressed("CLICK"):
					left_size_dragging = true
					starting_mouse_pos.x = get_global_mouse_position().x
					starting_window_pos.x = rect_position.x
					starting_window_size = window_size
					
		if get_local_mouse_position().x > 0 and get_local_mouse_position().x < window_size.x:
			if get_local_mouse_position().y > window_size.y - 5 and get_local_mouse_position().y < window_size.y + 5:
				draw_line(Vector2(get_local_mouse_position().x,window_size.y - 5), Vector2(get_local_mouse_position().x,window_size.y + 5), Color.white,5)
				if Input.is_action_just_pressed("CLICK"):
					down_size_dragging = true
					starting_mouse_pos.y = get_global_mouse_position().y
					starting_window_pos.y = window_size.y
			
			if get_local_mouse_position().y > -18 and get_local_mouse_position().y < -12:
				draw_circle(Vector2(get_local_mouse_position().x,-12),4,Color.white)



func _input(event: InputEvent) -> void:
	
	if get_global_mouse_position().x > window_pos.x and get_global_mouse_position().x < window_size.x + window_pos.x and get_global_mouse_position().y > window_pos.y - 18 and get_global_mouse_position().y < window_size.y + window_pos.y:
		hovered = true
	else:
		hovered = false
	
	if Input.is_action_pressed("CLICK") and right_size_dragging:
		var mouse_delta = get_global_mouse_position().x - starting_mouse_pos.x
		$container.rect_size.x = starting_window_pos.x + mouse_delta
		window_size.x = $container.rect_size.x
		temporary_size_active = false
		
	if Input.is_action_pressed("CLICK") and left_size_dragging:
		var mouse_delta = get_global_mouse_position().x - starting_mouse_pos.x
		rect_position.x = starting_window_pos.x + mouse_delta
		window_pos.x = rect_position.x
		
		window_size.x = (-mouse_delta) + starting_window_size.x
		$container.rect_size.x = window_size.x
		temporary_size_active = false
		
	if Input.is_action_pressed("CLICK") and down_size_dragging:
		var mouse_delta = get_global_mouse_position().y - starting_mouse_pos.y
		$container.rect_size.y = starting_window_pos.y + mouse_delta
		window_size.y = $container.rect_size.y
		temporary_size_active = false
		
	
	if Input.is_action_just_released("CLICK"):
		right_size_dragging = false
		left_size_dragging = false
		down_size_dragging = false
	
	if hovered:
		if Input.is_action_pressed("CTRL") and Input.is_action_just_pressed("F"):
			fullscreen()
		if Input.is_action_just_pressed("CLICK"):
			show_on_top = true
			focused = true
			$top_window/ColorRect.modulate = Color.white
			
			name_node.modulate = Color.white
			icon_node.modulate = Color.white
			global.focused_window = self
	else:
		if Input.is_action_just_pressed("CLICK"):
			focused = false
			show_on_top = false
			$top_window/ColorRect.modulate = Color.black
			
			name_node.modulate = Color.white
			icon_node.modulate = Color.white


		
func _ready() -> void:
	$container.rect_size = Vector2.ZERO
	rect_position *= 2.5

	show_on_top = true
	focused = true
	$top_window/ColorRect.modulate = Color.white
	
	name_node.modulate = Color.white
	icon_node.modulate = Color.white
	global.focused_window = self
	name_node.bbcode_text = window_name
	

func _physics_process(delta: float) -> void:
	update()
	icon_node.texture = window_icon
	
	$top_window.rect_position = $container.rect_position + Vector2(1,-12)
	$top_window.rect_size.x = $container.rect_size.x - 3
	
	$container/ColorRect2.rect_size.y /= 1.2
	control.rect_position.x = ($container.rect_size.x - control.rect_size.x)
	
	$hover.rect_position = $top_window.rect_position + Vector2(0,-12)
	$hover.rect_size = $container.rect_size + Vector2(0, 12)
	
	hover_size.rect_size.x = $container.rect_size.x - 65
	
	$container.rect_size += (window_size - $container.rect_size) * 0.2
	rect_position += (window_pos - rect_position) * 0.2
	
	if content != null:
		content.rect_size = $container.rect_size
		
#	if show_on_top:
#		$container.self_modulate = $container.self_modulate.linear_interpolate(Color.white,delta * 15)
#	else:
#		$container.self_modulate = $container.self_modulate.linear_interpolate(Color.darkgray,delta * 15)
	pan()
	
var dragging := false

func pan():
	if hover_size.is_clicking():
		if Input.is_action_just_pressed("CLICK"):
			dragging = true
			if temporary_size_active:
				window_pos = last_windowed_pos
				window_size = last_windowed_size
				temporary_size_active = false
			starting_mouse_pos = get_global_mouse_position()
			starting_window_pos = rect_position
			
		if Input.is_action_pressed("CLICK") and dragging:
			var mouse_delta = get_global_mouse_position() - starting_mouse_pos
			rect_position = starting_window_pos + mouse_delta
			window_pos = rect_position
			
	if Input.is_action_just_released("CLICK"):
		dragging = false
		
	if hover_size.is_click_release():
		temporary_size_active = true
		last_windowed_pos = window_pos
		last_windowed_size = window_size
		
		if get_global_mouse_position().x < 10:
			window_pos = maximized_window_pos
			window_size.x = maximized_window_size.x / 2
			window_size.y = maximized_window_size.y
			window_size.x += 2
		elif get_global_mouse_position().x > 630:
			window_pos.x = maximized_window_size.x / 2
			
			window_pos.y = maximized_window_pos.y
			window_size.x = maximized_window_size.x / 2
			window_size.y = maximized_window_size.y
			
		if get_global_mouse_position().y < 10:
			fullscreen()
		
func fullscreen():
	if fullscreenable:
		if fullscreen == false:
			last_windowed_pos = window_pos
			last_windowed_size = window_size
			window_pos = maximized_window_pos
			window_size = maximized_window_size
		else:
			window_pos = last_windowed_pos
			window_size = last_windowed_size
		fullscreen = !fullscreen
	
func minimize():
	if minimized == false:
		last_windowed_pos = window_pos
		last_windowed_size = window_size
		window_pos.y = 380
		window_pos.x *= 2
		window_size.y = -111110
		window_size.x /= 2
	else:
		window_pos = last_windowed_pos
		window_size = last_windowed_size
		
	minimized = !minimized

func _on_Button_pressed() -> void:
	
	global.kill_window(self.get_index())
	global.taskbar_scene.refresh_windows()

func _on_Button3_pressed() -> void:
	fullscreen()

func _on_Button2_pressed() -> void:
	minimize()


