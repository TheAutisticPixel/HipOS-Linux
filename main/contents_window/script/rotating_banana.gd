extends Control

var show_toggle = false

func _ready() -> void:
	get_parent().get_parent().modulate = Color.yellow
	get_parent().get_parent().window_name = "[wave]Rotating Banana"

func _physics_process(delta: float) -> void:
	if get_parent().get_parent().hovered:
		if Input.is_action_just_pressed("RIGHT_CLICK"):
			show_toggle = !show_toggle
			
	if show_toggle:
		$Button.show()
		$TextureRect2.show()
	else:
		$Button.hide()
		$TextureRect2.hide()
	
func _on_Button_pressed() -> void:
	if $funky_town_mp3.playing:
		$Button.text = "Banana music: Off"
		$funky_town_mp3.playing = false
	else:
		$Button.text = "Banana music: On"
		$funky_town_mp3.playing = true
		
