extends Control


onready var notif = $notif.duplicate()
var notifs = []

var last_notif = null

func _ready() -> void:
	global.notif_scene = self
	$notif.queue_free()
	
func make_notif(text = "test text lmfao", icon = null, color = Color.white):
	var notif_inst = notif.duplicate()
	notif_inst.rect_position = $anchor.position 
	notif_inst.get_node("text").text = text
	notif_inst.get_node("sprite").texture = icon
	notif_inst.modulate = color
	$container.add_child(notif_inst)
		
	$container.rects = $container.get_children()
