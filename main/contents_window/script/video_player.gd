extends Control

onready var video_size = $video.rect_size
onready var video = $video

func _physics_process(delta: float) -> void:

	$player/timeline.value = video.stream_position

func _on_video_finished() -> void:
	$video.play()
