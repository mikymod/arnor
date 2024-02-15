class_name Pawn
extends Unit

@onready var _gathering_progress: GatheringProgress = $GatheringProgress

var pine_tree: PineTree
var gold_mine: GoldMine


func cut() -> void:
	state_machine.transition_to("Cut")


func mine() -> void:
	state_machine.transition_to("Mine")


func _on_interaction_body_entered(body: Node2D) -> void:
	#if body.is_in_group(UnitGroup.keys()[UnitGroup.ENEMIES]):
		#_units_in_range.append(body)
	#if body is PineTree:
		#pine_tree = body as PineTree
		#var cut_pos = pine_tree.get_cut_position()
		#agent.target_position = cut_pos.global_position
		#agent.navigation_finished.connect(_on_pine_tree_reached)
	#elif body is GoldMine:
		#gold_mine = body as GoldMine
		#var gather_pos = gold_mine.get_gather_position()
		#agent.target_position = gather_pos.global_position
		#agent.navigation_finished.connect(_on_gold_mine_reached)
	pass

func _on_pine_tree_reached() -> void:
	agent.navigation_finished.disconnect(_on_pine_tree_reached)
	cut()

func _on_gold_mine_reached() -> void:
	agent.navigation_finished.disconnect(_on_gold_mine_reached)
	mine()


func _on_interaction_area_entered(area: Area2D) -> void:
	if area is PineTree:
		pine_tree = area as PineTree
		var cut_pos = pine_tree.get_cut_position()
		agent.target_position = cut_pos.global_position
		agent.navigation_finished.connect(_on_pine_tree_reached)
	elif area is GoldMine:
		gold_mine = area as GoldMine
		var gather_pos = gold_mine.get_gather_position()
		agent.target_position = gather_pos.global_position
		agent.navigation_finished.connect(_on_gold_mine_reached)
