extends Line2D

#@export var effect_events: Resource

var card: Card
#var effect: Effect
var target_mask: int = 0
var left_button_pressed: bool = false

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#left_button_pressed = event.pressed and event.button_index == MOUSE_BUTTON_LEFT
		#if left_button_pressed:
			#select_target()

func _process(_delta: float) -> void:
	draw_arrow()
	
#func init(card: Card, effect: Effect, position: Vector2, mask: int):
	#self.card = card
	#self.effect = effect
	#global_position = position
	#target_mask = mask

#func select_target() -> void:
	#var result
	#var space_state = get_world_2d().direct_space_state
	#var mouse_pos = get_global_mouse_position()
	#var query = PhysicsPointQueryParameters2D.new()
	#query.collide_with_areas = true
	#query.collision_mask = target_mask
	#query.exclude = [self]
	#query.position = mouse_pos
	#result = space_state.intersect_point(query)
	#if result and result[0].collider != card:
		#if result[0].collider.has_method("set_selected"):
			#if result[0].collider.selected: return
			#result[0].collider.set_selected(true)
		#effect.target_selected.emit(result[0])

func draw_arrow() -> void:
	var start_pos = global_position
	var final_pos = get_viewport().get_mouse_position()
	
	clear_points()
	var curve = Curve2D.new()
	curve.add_point(
		to_local(start_pos),
		Vector2(0,0),
		start_pos.direction_to(get_viewport().size / 2) * 75
	)
	curve.add_point(to_local(final_pos), Vector2(0, 0), Vector2(0, 0))
	set_points(curve.get_baked_points())

	var arrow_head_pos = get_point_position(get_point_count() - 2)
	for _del in range(1,4):
		remove_point(get_point_count( ) - 1)
	$ArrowHead.position = arrow_head_pos
	$ArrowHead.rotation = to_local(start_pos).direction_to(arrow_head_pos).angle()
