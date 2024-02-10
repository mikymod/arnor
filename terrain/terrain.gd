extends Node2D

@onready var _camera: Camera2D = $Camera2D

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		_camera.get_target_position()
		_camera.global_position.y = roundi(_camera.global_position.y - event.relative.y)

func set_input(enable: bool) -> void:
	set_process_input(enable)
