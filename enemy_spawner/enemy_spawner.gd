extends Node2D

export(PackedScene) var enemy_scene
export(float) var wait_time

onready var _timer: Timer = $SpawnTimer

func _ready() -> void:
	_timer.wait_time = wait_time
	_timer.start()

func _on_SpawnTimer_timeout():
	var enemy = enemy_scene.instance()
	add_child(enemy)
