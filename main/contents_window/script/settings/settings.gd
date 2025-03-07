extends Control

var buttons = []

onready var toggle_btn = $button_package/toggle.duplicate()
onready var slider_btn = $button_package/slider.duplicate()
onready var dropdown_btn = $button_package/dropdown.duplicate()
onready var textfield_btn = $button_package/text_field.duplicate()
onready var button_btn = $button_package/button.duplicate()
onready var separator = $button_package/separator.duplicate()

onready var container = $container

var unhover_color = Color8(0,0,0,255)
var unhover_color_element = Color8(177,177,177,255)
var hover_color = Color8(43,43,43,255)
var hover_color_element = Color8(255,255,255,255)

var scroll = 0
var last_size = 0

func _ready() -> void:
	for i in range(global.config.size()):
		var conf_prefix = global.config[i][0][0]
		print(conf_prefix)
		
		if conf_prefix == "t":
			var toggle_inst = toggle_btn.duplicate()
			buttons.append(toggle_inst)
			container.add_child(toggle_inst)
		if conf_prefix == "s":
			var slider_inst = slider_btn.duplicate()
			buttons.append(slider_inst)
			container.add_child(slider_inst)
		if conf_prefix == "d":
			var dropdown_inst = dropdown_btn.duplicate()
			buttons.append(dropdown_inst)
			container.add_child(dropdown_inst)
		if conf_prefix == "x":
			var textfield_inst = textfield_btn.duplicate()
			buttons.append(textfield_inst)
			container.add_child(textfield_inst)
		if conf_prefix == "b":
			var button_inst = button_btn.duplicate()
			buttons.append(button_inst)
			container.add_child(button_inst)
			
		if global.config[i].size() == 1:
			var separator_inst = separator.duplicate()
			buttons.append(separator_inst)
			container.add_child(separator_inst)
			
	for i in range(buttons.size()):
		var p = buttons[i]
		if p.get_class() != "Label":
			p.unhover_color = unhover_color
			p.unhover_color_element = unhover_color_element
			p.hover_color = hover_color
			p.hover_color_element = hover_color_element
			
			
		p.rect_position.x = $container/anchor.position.x
			
	$button_package.queue_free()

func _input(event: InputEvent) -> void:
	if get_parent().get_parent().hovered:
		if Input.is_action_pressed("SCROLL_DOWN"):
			scroll += 35
		if Input.is_action_pressed("SCROLL_UP"):
			scroll -= 35
func _physics_process(delta: float) -> void:
	
	container.rect_position.y += ((14 - scroll) - container.rect_position.y) * 0.2
	
	if buttons != []:
		buttons.front().rect_position.y += (0 - buttons.front().rect_position.y) * 0.5
	for i in range(buttons.size() - 1):
		buttons[i + 1].rect_position.y += ( ( buttons[i].rect_position.y + (buttons[i].rect_size.y + 2)) - buttons[i + 1].rect_position.y) * 0.5

		
	if last_size != get_parent().rect_size.x:
		for i in buttons:
			i.rect_size.x = get_parent().rect_size.x - 30
		last_size = get_parent().rect_size.x
		
