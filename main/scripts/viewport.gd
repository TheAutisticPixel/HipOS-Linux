extends Viewport

onready var rotation = $Camera.rotation_degrees
var rot = Vector3.ZERO

func _physics_process(delta: float) -> void:
	$Spatial/CSGTorus.rotation_degrees += Vector3.ONE * delta * 8
	$Spatial/CSGTorus2.rotation_degrees -= Vector3.ONE * delta * 3
	$Spatial/CSGTorus3.rotation_degrees -= Vector3.ONE * delta * 10
	$Spatial/CSGTorus4.rotation_degrees += Vector3.ONE * delta * 5
	$Spatial/Spatial.rotation_degrees += Vector3.ONE * delta * 5
	
	
	$Camera.h_offset += (sin(OS.get_ticks_msec() * delta * 0.1) * 0.3 - $Camera.h_offset) * 0.01
	$Camera.v_offset += (sin(OS.get_ticks_msec() * delta * 0.1) * -0.3 - $Camera.v_offset) * 0.01
#	
#	rot += (Vector3(rand_range(-3,3),rand_range(-3,3),rand_range(-3,3)) - rot) * 0.1
#	$Camera.rotation_degrees += ((rotation + rot) - $Camera.rotation_degrees) * 0.05
