extends Control


onready var notif = $notif.duplicate()
var notifs = []

var last_notif = null

func _ready() -> void:
	global.notif_scene = self
	$notif.queue_free()
	
func make_notif(text = "test text lmfao", icon = null, color = Color.white):
	var notif_inst = notif.duplicate()
	var add_y = 0
	if get_tree().get_nodes_in_group("notif") != []:
		add_y = get_tree().get_nodes_in_group("notif").back().margin_bottom
	notif_inst.rect_position = $anchor.position + Vector2(0,add_y)
	notif_inst.get_node("text").text = text
	notif_inst.get_node("sprite").texture = icon
	notif_inst.modulate = color
	notif_inst.timer += rand_range(-0.8, 0.9)
	$container.add_child(notif_inst)
		
	$container.rects = $container.get_children()
	
