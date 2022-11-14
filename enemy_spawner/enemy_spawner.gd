extends Node2D

export var enemy_res: PackedScene

onready var _timer: Timer = $SpawnTimer

func _on_SpawnTimer_timeout():
	var enemy = enemy_res.instance()
	add_child(enemy)
