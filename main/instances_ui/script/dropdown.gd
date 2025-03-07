extends NinePatchRect
class_name dropdown

var count = -8
var buttons = [
	"Minimize all programs",
	"",
	"Create new folder",
	"Create new text file",
	"Start menu",
	"",
	"Text editor",
	"Stock Trading",
	"Pie Clicker",
	"",
	"System information",
	"Settings",
	"",
	"Shut down computer",
	
]

var icons = [
	null,
	null,
	preload("res://art/icons/folder.png"),
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/icons/start_tiny.png"),
	null,
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/stock_trading/icon.png"),
	preload("res://art/app_art/pie_clicker/icon.png"),
	null,
	null,
	preload("res://art/icons/settings.png"),
	null,
	preload("res://art/icons/power_off.png"),
	
]

var buttons_dropdown = []

onready var btn_inst = $btn.duplicate()
onready var separetor = $separator.duplicate()

var offset = Vector2.ZERO
var hovered = true

func _ready() -> void:
	$btn.queue_free()
	$separator.queue_free()
	
	for i in range(buttons.size()):
		var p = buttons[i]
		var button_inst = btn_inst.duplicate()
		button_inst.get_node("text").text = p
		button_inst.rect_position.y = 2 + i * 16
		button_inst.rect_position.x -= 15
		button_inst.get_node("text").rect_position.y += 500
		button_inst.get_node("icon").position.x -= 5500
		if p == "":
			button_inst.hide()
		add_child(button_inst)
		buttons_dropdown.append(button_inst)
	for i in range(icons.size()):
		if icons[i] != null:
			buttons_dropdown[i].get_node("icon").texture = icons[i]
			buttons_dropdown[i].rect_min_size.x = 1
	
	rect_position.x = clamp(rect_position.x, 0, (640 - 160) - offset.x)
	rect_position.y = clamp(rect_position.y, 0, 360 - (15 + buttons.size() * 17))

var last_hovered_text = ""
var hovered_text = ""
var quit = false

func _physics_process(delta: float) -> void:
	
	if last_hovered_text != hovered_text:
		$sfx.play()
		last_hovered_text = hovered_text
	
	if not hovered:
		if Input.is_action_just_pressed("CLICK") or Input.is_action_just_pressed("RIGHT_CLICK"):
			quit = true

	if get_global_mouse_position().x > rect_position.x and get_global_mouse_position().x < margin_right and get_global_mouse_position().y > rect_position.y and get_global_mouse_position().y < margin_bottom:
		hovered = true
		self_modulate = self_modulate.linear_interpolate(Color(1,1,1,0.5),delta * 15)
	else:
		self_modulate = self_modulate.linear_interpolate(Color(1,1,1,0.1),delta * 15)
		
		hovered = false
		
	if quit == false:
		rect_size.x += (160 - rect_size.x) * 0.2
		if rect_size.x >= 155:
			rect_size.y += (15 + buttons.size() * 17 - rect_size.y) * 0.2
			$flash.rect_position.y += (15 + buttons.size() * 17 - $flash.rect_position.y) * 0.2
			
			if count < buttons_dropdown.size():
				count += delta * 30
	else:
		$ColorRect.show_on_top = true
		$ColorRect.modulate = $ColorRect.modulate.linear_interpolate(Color.white,delta * 5)
		rect_size.y /= 1.4
		if rect_size.y < 5:
			rect_size.x /= 1.4
			rect_position.x += 10
			if rect_size.x < 5:
				queue_free()
	
	for i in range(count):
		var p = buttons_dropdown[i]
		p.rect_position = p.rect_position.linear_interpolate(Vector2(7,7) + Vector2(0,i * 17),delta * 15)
		p.rect_size.x += (147 - p.rect_size.x) * 0.2
		p.get_node("text").rect_position.x += 4
		
		p.get_node("icon").position = p.get_node("icon").position.linear_interpolate(Vector2(10,10),delta * 15)
		if get_local_mouse_position().x > p.rect_position.x and get_local_mouse_position().x < p.margin_right and get_local_mouse_position().y > p.rect_position.y and get_local_mouse_position().y < p.margin_bottom:
			if buttons[i] != "":
				hovered_text = buttons[i]
				p.self_modulate = p.self_modulate.linear_interpolate(Color.white,delta * 15)
				p.get_node("bg").modulate = p.get_node("bg").modulate.linear_interpolate(Color.white,delta * 15)
				p.get_node("icon").modulate = p.get_node("icon").modulate.linear_interpolate(Color.black,delta * 15)
				p.get_node("text").modulate = p.get_node("text").modulate.linear_interpolate(Color.black,delta * 15)
				p.get_node("text").rect_position = p.get_node("text").rect_position.linear_interpolate(Vector2(10,5),delta * 15)
		
		else:
			p.self_modulate = p.self_modulate.linear_interpolate(Color(0.2,0.2,0.2,0.5),delta * 15)
			p.get_node("bg").modulate = p.get_node("bg").modulate.linear_interpolate(Color.black,delta * 15)
			p.get_node("icon").modulate = p.get_node("icon").modulate.linear_interpolate(Color.darkgray,delta * 15)
			p.get_node("text").modulate = p.get_node("text").modulate.linear_interpolate(Color.darkgray,delta * 15)
			p.get_node("text").rect_position = p.get_node("text").rect_position.linear_interpolate(Vector2(6,5),delta * 15)
	


func _on_dropdown_mouse_entered() -> void:
	hovered = true
func _on_dropdown_mouse_exited() -> void:
	hovered = false
