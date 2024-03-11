class_name PlayerBar
extends Control

@export var player: Player

func _ready() -> void:
	update()
	player.gold_changed.connect(_on_gold_changed)
	player.level_reached.connect(_on_level_reached)

func _on_gold_changed() -> void:
	update()

func _on_level_reached() -> void:
	update()

func update() -> void:
	$ColorRect/GoldLabel.text = str(player.gold)
	$ColorRect/LevelLabel.text = str(player.level)

func add_gold(amount: int) -> void:
	player.add_gold(amount)

func add_exp(amount: int) -> void:
	player.add_exp(amount)
