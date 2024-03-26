class_name Encounter
extends Node

signal started()
signal finished()
signal failed()

@export var encounter_resource: EncounterResource

@onready var player_area: PlayerArea = $PlayerArea
@onready var enemy_area: PlayerArea = $PlayerArea2

func on_spawner_timeout(spawn_position: Vector2) -> void:
	var card_res: CardResource = encounter_resource.enemy_resource.deck_resource.get_random()
	enemy_area.play_card(card_res, spawn_position)

func start() -> void:
	started.emit()

func finish() -> void:
	finished.emit()

func game_over() -> void:
	failed.emit()
