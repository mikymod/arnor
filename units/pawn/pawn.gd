class_name Pawn
extends Unit

@onready var _gathering_bar: GatheringBar = $GatheringBar
@export var supply_scene: PackedScene = preload("res://supplies/gold_spawn.tscn")

var _gold_mine: GoldMine

func cut() -> void:
	state_machine.transition_to("Cut")

func mine() -> void:
	state_machine.transition_to("Mine")

func _on_interaction_area_entered(area: Area2D) -> void:
	if area is GoldMine:
		_gold_mine = area as GoldMine
		var gather_pos = _gold_mine.get_gather_position()
		agent.target_position = gather_pos.global_position
		agent.navigation_finished.connect(_on_gold_mine_reached)

func _on_gold_mine_reached() -> void:
	agent.navigation_finished.disconnect(_on_gold_mine_reached)
	_gathering_bar.gathering_stopped.connect(on_gathering_stopped)
	_gathering_bar.start()
	mine()

func on_gathering_stopped():
	player_resource.increase_mana(10)
	_gathering_bar.gathering_stopped.disconnect(on_gathering_stopped)
	var supply = supply_scene.instantiate()
	supply.position = _gold_mine.get_supply_position().position
	_gold_mine.add_child(supply)
	state_machine.transition_to("Walk")

func _exit_tree():
	if agent.navigation_finished.is_connected(_on_gold_mine_reached):
		agent.navigation_finished.disconnect(_on_gold_mine_reached)
	if _gathering_bar.gathering_stopped.is_connected(on_gathering_stopped):
		_gathering_bar.gathering_stopped.disconnect(on_gathering_stopped)
