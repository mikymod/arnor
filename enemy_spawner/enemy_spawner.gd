extends Node2D

export var enemy_scene: PackedScene

onready var _timer: Timer = $SpawnTimer

func _on_SpawnTimer_timeout():
	var enemy = enemy_scene.instance()
	add_child(enemy)
