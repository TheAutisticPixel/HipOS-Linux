extends Control

onready var original_btn_layout = $container.get_children()
onready var buttons = $container.get_children()

var contained_searches = []

var rect = []
var pos = []
var spr_pos = []
var count = 0

onready var anim = $bg/animation.get_children()
var anim_count = 0
var anim_pos = []
var anim_scale = []
var fobber = false

var quit = false
var quit_timer = 0.5

var last_scroll = 0
var last_ms_pos = 0

var text_field = ""

var hovered = null
var touch = false

var ethereal = preload("res://sfx/back_ethereal.wav")

func _ready() -> void:

	
#	$bg/animation.rect_position.x = 1000
	global.sfx(ethereal,-10,0.1)
	global.sfx(ethereal,-10,0.8)
	global.sfx(ethereal,0,0.5)
	global.sfx(ethereal,-5,0.3)
	global.sfx(ethereal,-5,1)
	global.sfx(ethereal,-15,0.4)
	
	for i in buttons:
		pos.append(i.rect_position)
		rect.append(i.rect_size)
		spr_pos.append(i.get_node("Sprite").position)
	for i in range(buttons.size()):
		var p = buttons[i]
		var flash = ColorRect.new()
		if fobber:
			p.spin_speed = -0.1
		else:
			p.spin_speed = 0.1
		fobber = !fobber
		flash.mouse_filter = Control.MOUSE_FILTER_IGNORE
		flash.rect_size = Vector2.ONE * (p.rect_size.length() * (1 * ((i + 1) * 2)))
		flash.rect_position = Vector2(rect_size.y / 4,-rect_size.y / 3)
		flash.rect_rotation = 45
		flash.show_behind_parent = true
		flash.name = "flash"
		p.add_child(flash)
		p.get_node("text").modulate = Color(0,0,0,5555)
		p.rect_position.x += 1000 + p.rect_size.x 
		p.rect_position.y += p.rect_size.y / 2
		p.rect_size = Vector2.ZERO

	$bg.modulate = Color.transparent
	modulate = Color.transparent
	
#	anim.shuffle()
	
	for i in range(anim.size()):
		var p = anim[i]
		anim_pos.append(p.rect_position)
		anim_scale.append(p.rect_size)
		fobber = !fobber
		if fobber:
			p.rect_size.y = 0
		else:
			p.rect_size.x = 0
		
		if p.get_class() == "Label":
			p.rect_size.x = 0
			p.rect_size.y = 0
			
var scroll = 0

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		touch = !touch
		last_ms_pos = get_local_mouse_position().x
		last_scroll = scroll
	if Input.is_action_pressed("SCROLL_DOWN"):
		scroll += 85
	if Input.is_action_pressed("SCROLL_UP"):
		scroll -= 85

onready var bg_scrolls = $bg.get_children()

func _physics_process(delta: float) -> void:
	
	$LineEdit.rect_position = $LineEdit.rect_position.linear_interpolate(Vector2(455,40),delta * 5)
	
	for i in range(bg_scrolls.size()):
		bg_scrolls[i].rect_position.x += (-scroll / (7 - (i * 2)) - bg_scrolls[i].rect_position.x) * 0.1
	
	$container.rect_position.x += ((38 - scroll) - $container.rect_position.x ) * 0.2
	$bg.modulate = $bg.modulate.linear_interpolate(Color.white,delta * 5)
	
	scroll += ((clamp(scroll,0,buttons.back().margin_right - 450)) - scroll) * 0.3
	
	if Input.is_action_just_pressed("CLICK") :
		last_ms_pos = get_local_mouse_position().x
		last_scroll = scroll
		
	if Input.is_action_pressed("CLICK") or touch:
		if touch:
			scroll = last_scroll - (get_local_mouse_position().x - last_ms_pos) * 3
		else:
			scroll = last_scroll - (get_local_mouse_position().x - last_ms_pos) 
	
	if count < buttons.size():
		count += delta * 25
	
	if anim_count < anim.size():
		anim_count += delta * 55
	anim_count = clamp(anim_count,0,anim.size())
	
	if anim_count < anim.size():
		for i in range(anim_count):
#			anim[i].rect_position = anim[i].rect_position.linear_interpolate(anim_pos[i],delta * 5)
			anim[i].rect_size = anim[i].rect_size.linear_interpolate(anim_scale[i],delta * 10)
	
	if quit == false:
		global.main_scene.get_node("start_menu").open = true
		modulate = modulate.linear_interpolate(Color.white,delta * 5)
		
		if contained_searches == []:
			for i in range(count):
				var p = buttons[i]
				p.show()
				p.get_node("flash").rect_size.x /= 1.1
				p.rect_position = p.rect_position.linear_interpolate(pos[i],delta * 10)
				p.rect_size = p.rect_size.linear_interpolate(rect[i],delta * 10)
		else:
			for i in buttons:
				i.hide()
			for i in range(contained_searches.size()):
				contained_searches[i].show()
				contained_searches[i].rect_position = contained_searches[i].rect_position.linear_interpolate(pos[i],delta * 15)
				contained_searches[i].rect_size = contained_searches[i].rect_size.linear_interpolate(rect[i],delta * 10)
				
				var ms = $container.get_local_mouse_position()
				if ms.x > contained_searches[i].rect_position.x and ms.x < contained_searches[i].margin_right:
					if ms.y > contained_searches[i].rect_position.y and ms.y < contained_searches[i].margin_bottom:
						contained_searches[i].hovered = true
					else:
						contained_searches[i].hovered = false
				else:
					contained_searches[i].hovered = false
				
	else:
		quit_timer -= delta * 2
		for i in buttons:
			i.rect_position.x *= 1.05
			i.rect_size.y /= 1.3
		modulate = modulate.linear_interpolate(Color.transparent,delta * 8)
		if quit_timer < 0:
			global.main_scene.get_node("start_menu").open = false
			
			queue_free()
		
		if Input.is_action_just_released("START"):
			global.main_scene.get_node("start_menu").open = false
	
	
	if count > 1 and Input.is_action_just_pressed("START"):
		quit = true
		
var window_name = [
	"Text editor",
	"Settings",
	"File browser",
	"System Information",
	"Stock Trading",
	"Video Player",
	"Shooting Game",
	"Shapes",
]

var icons = [
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/icons/settings.png"),
	preload("res://art/icons/folder.png"),
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/stock_trading/icon.png"),
	preload("res://art/app_art/text editor/icon.png"),
	preload("res://art/app_art/shooting_game/icon.png"),
	preload("res://art/app_art/shapes/icon.png"),
]

var windows = [
	preload("res://main/contents_window/text_editor.tscn"),
	preload("res://main/contents_window/settings.tscn"),
	preload("res://main/contents_window/file_browser.tscn"),
	preload("res://main/contents_window/system_information.tscn"),
	preload("res://main/contents_window/stock_trading.tscn"),
	preload("res://main/contents_window/video_player.tscn"),
	preload("res://main/component/shooting_game.tscn"),
	preload("res://main/contents_window/shapes.tscn"),
]

func launch(who = null):
	for i in range(buttons.size()):
		if buttons[i] == who:
			if i < windows.size():
				global.make_window(window_name[i],windows[i],icons[i])
				quit = true

func _on_LineEdit_text_changed(new_text: String) -> void:
	
#	contained_searches = []
	
#	for i in range(buttons.size()):
#		var text = buttons[i].get_node("text").text.to_lower()
#		var search = $bg/Control/LineEdit.text.to_lower()
#
#		for o in text.length():
#			for p in search.length():
#				if text[o] == search[p]:
#					if contained_searches.find(buttons[i]) != i:
#						contained_searches.append(buttons[i]) 
	
	contained_searches = []

	for i in range(buttons.size()):
		var text_btn = buttons[i].get_node("text").text.to_lower()
		var similar = $LineEdit.text.to_lower().similarity(text_btn)
		if similar > float($LineEdit.text.length() / 25.0) * 1.0:
			contained_searches.append(buttons[i])
		buttons[i].hovered = false
			
#	contained_searches = []
#
#	for i in range(buttons.size()):
#		var text_btn = buttons[i].get_node("text").text.to_lower()
#		var regex = RegEx.new()
#		regex.compile(text_btn)
#		var result = regex.search_all($bg/Control/LineEdit.text.to_lower())
#
#		for o in result:
#			if o.subject.to_lower() == text_btn:
#				contained_searches.append(buttons[i])
#				print(contained_searches)
#
	
	
