extends Node2D

export(Array, Resource) var enemy_wave_list

onready var spawn_points: Array = [
	$SpawnPoints/EnemySpawner,
	$SpawnPoints/EnemySpawner2,
	$SpawnPoints/EnemySpawner3,
	$SpawnPoints/EnemySpawner4,
]

var _current_wave: int = 0
var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	$Timer.wait_time = enemy_wave_list[_current_wave].start_after
	$Timer.one_shot = false
	$Timer.autostart = false
	$Timer.start()

func _on_Timer_timeout():
	spawn_wave()
	var current_duration = enemy_wave_list[_current_wave].duration
	_current_wave += 1
	if _current_wave == enemy_wave_list.size():
		$Timer.stop()
	else:
		$Timer.wait_time = current_duration + enemy_wave_list[_current_wave].start_after
		$Timer.start()
		
func spawn_wave() -> void:
	print("wave num: ", _current_wave)
	var wave_res = enemy_wave_list[_current_wave]
	
	for i in range(wave_res.num_enemies):
		var random_spawn_point = spawn_points[_rng.randi_range(0, spawn_points.size() - 1)]
		var random_wait_time = _rng.randf_range(0.0, wave_res.duration / wave_res.num_enemies)
		var random_enemy_res = wave_res.enemy_resources[_rng.randi_range(0, wave_res.enemy_resources.size() - 1)]
		
		random_spawn_point.enemies.append({'enemy_resource': random_enemy_res, 'wait_time': random_wait_time})

	for spawn_point in spawn_points:
		spawn_point.start()
