extends Node2D

enum states {
	startup,
	main,
	shutdown,
}

var current_state = states.startup

var windows = []
var tasks = []

var current_hovered_windows = []
var startup = preload("res://main/instances_ui/startup_animation.tscn")


onready var window_container = $window_container
var shutdown_true = false

func _ready() -> void:
	global.main_scene = self
	var startup_inst = startup.instance()
	add_child(startup_inst)
	$CPUParticles2D/Line2D.set_as_toplevel(true)

var shutdown_scene = preload("res://main/instances_ui/shutdown_screen.tscn")
func shutdown():
	$start_menu.hide()
	$taskbar.hide()
	shutdown_true = true
	for i in global.windows:
		i.minimized()
	var shutdown_inst = shutdown_scene.instance()
	add_child(shutdown_inst)
	
var last_pos = Vector2.ZERO
	
func _process(delta: float) -> void:
	$CPUParticles2D.position = get_local_mouse_position() + Vector2.ONE * 8
	
	
	if is_instance_valid(global.focused_window):
		if global.focused_window.hide_cursor and global.focused_window.hovered:
			$CPUParticles2D.hide()
			$CPUParticles2D/Line2D.hide()
		else:
			$CPUParticles2D/Line2D.show()
			$CPUParticles2D.show()
		
		if global.focused_window.hovered == false:
			if Input.is_action_just_pressed("RIGHT_CLICK"):
				global.make_dropdown()
	else:
		if Input.is_action_just_pressed("RIGHT_CLICK"):
				global.make_dropdown()
	
	if last_pos != get_local_mouse_position():
		$CPUParticles2D.emitting = true
		last_pos = get_local_mouse_position()
	else:
		$CPUParticles2D.emitting = false
	
	if $CPUParticles2D/Line2D.get_point_count() < 5:
		$CPUParticles2D/Line2D.add_point($CPUParticles2D.global_position,$CPUParticles2D/Line2D.get_point_count())
	else:
		$CPUParticles2D/Line2D.remove_point(0)
		
