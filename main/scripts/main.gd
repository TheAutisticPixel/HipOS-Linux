extends Node2D

enum states {
	startup,
	main,
}

var current_state = states.startup

var windows = []
var tasks = []

var current_hovered_windows = []
var startup = preload("res://main/instances_ui/startup_animation.tscn")

onready var window_container = $window_container

func _ready() -> void:
	global.main_scene = self
	var startup_inst = startup.instance()
	add_child(startup_inst)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("RIGHT_CLICK"):
		global.make_notif("Hey hey hey... this is a test notification!!!. Go to the main script and disable this", null, Color.white)
