class_name Enemy
extends Unit

@onready var _state_machine: StateMachine = $StateMachine

func _ready() -> void:
	add_to_group("enemies")

func _process(delta: float) -> void:
	if has_nearby_units():
		_state_machine.transition_to("Attack")


func _on_interaction_area_2d_body_entered(body: Node2D):
	if body.is_in_group("allies"):
		var unit = body as Unit
		_units_in_range.append(unit)


func _on_interaction_area_2d_body_exited(body: Node2D):
	if body.is_in_group("allies"):
		var unit = body as Unit
		_units_in_range.erase(unit)
