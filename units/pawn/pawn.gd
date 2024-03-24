class_name Pawn
extends Unit

@onready var _gathering_progress: GatheringBar = $GatheringBar

func cut() -> void:
	state_machine.transition_to("Cut")

func mine() -> void:
	state_machine.transition_to("Mine")

func _on_gold_mine_reached() -> void:
	agent.navigation_finished.disconnect(_on_gold_mine_reached)
	mine()

func _on_interaction_area_entered(area: Area2D) -> void:
	if area is GoldMine:
		var gold_mine = area as GoldMine
		var gather_pos = gold_mine.get_gather_position()
		agent.target_position = gather_pos.global_position
		agent.navigation_finished.connect(_on_gold_mine_reached)

func on_gathering_timeout():
	state_machine.transition_to("Walk")
