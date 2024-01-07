class_name Pawn
extends Character

@onready var _state_machine: StateMachine = $StateMachine

var _pine_tree: PineTree
var _gold_mine: GoldMine


func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		_sprite.flip_h = velocity.x < 0

func cut() -> void:
	_state_machine.transition_to("PawnCutState")

func mine() -> void:
	_state_machine.transition_to("PawnMineState")

func _on_resource_body_entered(body: Node2D) -> void:
	if body is PineTree:
		_pine_tree = body as PineTree
		var cut_pos = _pine_tree.get_cut_position()
		_agent.target_position = cut_pos.global_position
		_agent.navigation_finished.connect(_on_pine_tree_reached)
	elif body is GoldMine:
		_gold_mine = body as GoldMine
		var gather_pos = _gold_mine.get_gather_position()
		_agent.target_position = gather_pos.global_position
		_agent.navigation_finished.connect(_on_gold_mine_reached)

func _on_pine_tree_reached() -> void:
	_agent.navigation_finished.disconnect(_on_pine_tree_reached)
	cut()

func _on_gold_mine_reached() -> void:
	_agent.navigation_finished.disconnect(_on_gold_mine_reached)
	mine()

