class_name Pawn
extends Unit

@onready var _state_machine: StateMachine = $StateMachine
@onready var _gathering_progress: GatheringProgress = $GatheringProgress

var pine_tree: PineTree
var gold_mine: GoldMine
var enemy: Enemy

func _ready() -> void:
	super._ready()


func cut() -> void:
	_state_machine.transition_to("PawnCutState")


func mine() -> void:
	_state_machine.transition_to("PawnMineState")


func _on_interaction_body_entered(body: Node2D) -> void:
	if body is PineTree:
		pine_tree = body as PineTree
		var cut_pos = pine_tree.get_cut_position()
		_agent.target_position = cut_pos.global_position
		_agent.navigation_finished.connect(_on_pine_tree_reached)
	elif body is GoldMine:
		gold_mine = body as GoldMine
		var gather_pos = gold_mine.get_gather_position()
		_agent.target_position = gather_pos.global_position
		_agent.navigation_finished.connect(_on_gold_mine_reached)
	elif body is Enemy:
		enemy = body as Enemy
		_state_machine.transition_to("Hammer")


func _on_pine_tree_reached() -> void:
	_agent.navigation_finished.disconnect(_on_pine_tree_reached)
	cut()

func _on_gold_mine_reached() -> void:
	_agent.navigation_finished.disconnect(_on_gold_mine_reached)
	mine()
