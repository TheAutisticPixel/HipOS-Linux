extends KinematicBody2D

var vel = Vector2.ZERO
var spd = 200

var spd_boost = Vector2.ZERO
onready var trail = $trail

onready var bullet = $bullet.duplicate()
var input = true

var fire_rate = 0.06

func _ready() -> void:
	$trail.set_as_toplevel(true)
	$bullet.queue_free()

func _process(delta: float) -> void:
	
	if trail.get_point_count() < 10 and spd_boost.length() > 41:
		trail.add_point(global_position, trail.get_point_count())
	else:
		trail.remove_point(0)
	
	fire_rate -= delta
	if input:
		vel += (Vector2( 
			(Input.get_action_strength("WALK_RIGHT") - Input.get_action_strength("WALK_LEFT")) * spd,
			(Input.get_action_strength("WALK_DOWN") - Input.get_action_strength("WALK_UP")) * spd ) - vel) * 0.16
		
		if Input.is_action_just_pressed("SHIFT"):
			spd_boost = Vector2( 
			(Input.get_action_strength("WALK_RIGHT") - Input.get_action_strength("WALK_LEFT")) * spd,
			(Input.get_action_strength("WALK_DOWN") - Input.get_action_strength("WALK_UP")) * spd ) 
		
		if Input.is_action_pressed("CLICK"):
			if fire_rate < 0:
				var bullet_inst = bullet.duplicate()
				bullet_inst.position = position
				bullet_inst.vel = (get_parent().ms_pos - position).normalized() * 800
				bullet_inst.vel += Vector2(rand_range(-150,150),rand_range(-150,150))
				get_parent().add_child(bullet_inst)
				fire_rate = 0.06
		
	if vel.length() > spd and spd_boost.length() < 1:
		vel = vel.normalized() * spd
		
	spd_boost /= 1.07
	vel += spd_boost
	
	move_and_slide(vel)
