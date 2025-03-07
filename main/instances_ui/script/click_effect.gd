extends Node2D

var end = false

func _physics_process(delta: float) -> void:
	if end:
		if $AnimationPlayer.current_animation_position <= 0:
			queue_free()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()
