extends Viewport


func _physics_process(delta: float) -> void:
	$Spatial/CSGTorus.rotation_degrees += Vector3.ONE * delta * 8
	$Spatial/CSGTorus2.rotation_degrees -= Vector3.ONE * delta * 3
	$Spatial/CSGTorus3.rotation_degrees -= Vector3.ONE * delta * 10
	$Spatial/CSGTorus4.rotation_degrees += Vector3.ONE * delta * 5
	$Spatial/Spatial.rotation_degrees += Vector3.ONE * delta * 5
