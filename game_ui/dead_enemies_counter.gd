extends Control

export(Resource) var enemy_events
var counter: int = 0

func _ready() -> void:
	enemy_events.connect("enemy_dead", self, "_on_enemy_dead")

func _process(delta: float) -> void:
	$HBoxContainer/CenterContainer/Label.text = str(counter)

func _on_enemy_dead() -> void:
	counter += 1
