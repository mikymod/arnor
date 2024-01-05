class_name Pawn
extends Character

@onready var _state_machine: StateMachine = $StateMachine


func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		_sprite.flip_h = velocity.x < 0

func cut() -> void:
	_state_machine.transition_to("PawnCutState")

func _on_resource_body_entered(body: Node2D) -> void:
	if body is PineTree:
		var pine_tree = body as PineTree
		var cut_pos = pine_tree.get_cut_position()
		_agent.target_position = cut_pos.global_position
		_agent.navigation_finished.connect(_on_pine_tree_reached)

func _on_pine_tree_reached() -> void:
	_agent.navigation_finished.disconnect(_on_pine_tree_reached)
	cut()

