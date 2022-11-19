extends StateMachine

var mouse_over: bool = false
var curr_event: InputEvent
var place: Area2D

onready var root: Area2D = owner
onready var init_pos: Vector2 = root.global_position

func _on_Card_mouse_entered() -> void:
	mouse_over = true

func _on_Card_mouse_exited() -> void:
	mouse_over = false

func _on_Card_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if mouse_over and (state is CardIdle or state is CardReturn):
		state._on_Card_input_event(event)

func _on_Card_area_entered(area: Area2D) -> void:
	place = area

func _on_Card_area_exited(_area: Area2D) -> void:
	place = null
