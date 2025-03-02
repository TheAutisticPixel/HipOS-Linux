extends Area2D

var vel = Vector2.ZERO
var lifetime = 2

func _init() -> void:
	look_at(vel)

func _ready() -> void:
	look_at(vel)

func _physics_process(delta: float) -> void:
	position += vel * delta
	
	rotation = vel.angle()

	lifetime -= delta
	if lifetime < 0:
		queue_free()
