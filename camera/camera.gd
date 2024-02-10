extends Camera2D


func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		get_target_position()
		global_position.y = roundi(global_position.y - event.relative.y)

## Sets input process
func set_input(enable: bool) -> void:
	set_process_input(enable)
