class_name Encounter
extends Node

signal started()
signal finished()
signal failed()

@export var encounter_res: EncounterResource

@onready var player_area: PlayerArea = $PlayerArea
@onready var enemy_area: PlayerArea = $PlayerArea2

func on_spawner_timeout(spawn_position: Vector2) -> void:
	var card_res: CardResource = encounter_res.player_resource.deck_resource.get_random()
	enemy_area.spawn_unit(card_res, spawn_position)

func start() -> void:
	started.emit()

func finish() -> void:
	finished.emit()

func game_over() -> void:
	failed.emit()
	
