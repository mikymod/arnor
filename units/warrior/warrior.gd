class_name Warrior
extends Unit

@onready var _state_machine: StateMachine = $StateMachine


func _ready() -> void:
	add_to_group("allies")


func _process(_delta: float) -> void:
	if has_nearby_units():
		_state_machine.transition_to("Attack")


func _on_interaction_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		var enemy = body as Enemy
		_units_in_range.append(enemy)


func _on_interaction_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		var enemy = body as Enemy
		_units_in_range.erase(enemy)
