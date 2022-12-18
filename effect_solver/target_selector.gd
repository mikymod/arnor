extends Node2D

signal target_selected(target)

var collision_mask: int = 0xffffffff

func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var space_state = get_world_2d().direct_space_state
		var mouse_pos = get_global_mouse_position()
		var result = space_state.intersect_ray(mouse_pos, mouse_pos, [self],
			collision_mask, true, true)
		if result:
			print(result)
			emit_signal('target_selected', result)
