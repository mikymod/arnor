extends Control

@export var enemy_events: EnemyEvents
var counter: int = 0

func _ready() -> void:
	enemy_events.enemy_dead.connect(_on_enemy_dead)

func _process(delta: float) -> void:
	$HBoxContainer/CenterContainer/Label.text = str(counter)

func _on_enemy_dead() -> void:
	counter += 1
