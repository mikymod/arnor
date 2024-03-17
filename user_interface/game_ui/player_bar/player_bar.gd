class_name PlayerBar
extends Control

@export var player: PlayerResource

@onready var xp_bar: ProgressBar = $ColorRect/XPBar

func _ready() -> void:
	player.gold_changed.connect(_on_gold_changed)
	player.exp_changed.connect(_on_xp_changed)
	player.level_reached.connect(_on_level_reached)
	_set_xp_bar_thresholds()
	update()

func _on_gold_changed() -> void:
	update()

func _on_xp_changed() -> void:
	update()

func _on_level_reached() -> void:
	_set_xp_bar_thresholds()
	update()

func update() -> void:
	$ColorRect/GoldLabel.text = str(player.gold)
	$ColorRect/LevelLabel.text = str(player.level)
	xp_bar.value = player.xp
	
func add_gold(amount: int) -> void:
	player.add_gold(amount)

func add_exp(amount: int) -> void:
	player.add_exp(amount)

func _set_xp_bar_thresholds() -> void:
	xp_bar.min_value = player.prev_level_threshold()
	xp_bar.max_value = player.next_level_threshold()
