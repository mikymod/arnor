class_name Pawn
extends Unit

@onready var _gathering_progress: GatheringProgress = $GatheringProgress

var pine_tree: PineTree
var gold_mine: GoldMine
var enemy: Enemy


func cut() -> void:
	state_machine.transition_to("Cut")


func mine() -> void:
	state_machine.transition_to("Mine")


func _on_interaction_body_entered(body: Node2D) -> void:
	if body.is_in_group(UnitGroup.keys()[UnitGroup.ENEMIES]):
		enemy = body as Enemy
		_units_in_range.append(enemy)
	elif body is PineTree:
		pine_tree = body as PineTree
		var cut_pos = pine_tree.get_cut_position()
		agent.target_position = cut_pos.global_position
		agent.navigation_finished.connect(_on_pine_tree_reached)
	elif body is GoldMine:
		gold_mine = body as GoldMine
		var gather_pos = gold_mine.get_gather_position()
		agent.target_position = gather_pos.global_position
		agent.navigation_finished.connect(_on_gold_mine_reached)

func _on_interaction_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group(UnitGroup.keys()[UnitGroup.ENEMIES]):
		enemy = body as Enemy
		_units_in_range.erase(enemy)

func _on_pine_tree_reached() -> void:
	agent.navigation_finished.disconnect(_on_pine_tree_reached)
	cut()

func _on_gold_mine_reached() -> void:
	agent.navigation_finished.disconnect(_on_gold_mine_reached)
	mine()
