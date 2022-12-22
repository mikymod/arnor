extends Node2D

export(Array, Dictionary) var enemies
export(PackedScene) var enemy_scene

onready var _timer: Timer = $SpawnTimer

var _current_index: int = 0

class MyCustomSorter:
	static func sort_ascending(a, b):
		if a.wait_time < b.wait_time:
			return true
		return false
		
func start() -> void:
	if enemies.size() <= 0:
		return
	enemies.sort_custom(MyCustomSorter, "sort_ascending")
	
	_timer.wait_time = enemies[_current_index].wait_time
	_timer.start()

func _on_SpawnTimer_timeout():
	var enemy = enemy_scene.instance()
	enemy.resource = enemies[_current_index].enemy_resource
	add_child(enemy)
	
	_current_index += 1
	if (_current_index >= enemies.size()):
		_timer.stop()
		_current_index = 0
		enemies.clear()
	else:
		_timer.wait_time = enemies[_current_index].wait_time
		_timer.start()
