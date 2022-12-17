extends Node2D

signal target_selected(target)

func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(get_global_mouse_position(),
			Vector2(50, 100), [self], 0x00000002, true, true)
		if result:
			print(result)
			emit_signal('target_selected', result)

