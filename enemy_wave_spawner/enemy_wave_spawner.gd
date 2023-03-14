extends Node2D

@export var turn_manager_resource: Resource

@export var enemy_scene: PackedScene

@export var enemy_wave_list: Array[EnemyWaveResource]

@onready var spawn_points: Array = [
	$SpawnPoints/SpawnPoint,
	$SpawnPoints/SpawnPoint2,
	$SpawnPoints/SpawnPoint3,
	$SpawnPoints/SpawnPoint4,
]

var _wave_res: Resource
var _current_wave: int = -1
var _num_enemies: int = 0
var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	turn_manager_resource.connect("wave_phase_started",Callable(self,"_on_wave_phase_started"))

func _on_wave_phase_started() -> void:
	_current_wave += 1
	if _current_wave >= enemy_wave_list.size():
		_current_wave = 0
		
	_wave_res = enemy_wave_list[_current_wave]
	_num_enemies = _wave_res.num_enemies
	
	$Timer.one_shot = false
	$Timer.autostart = false
	$Timer.start()

func _on_Timer_timeout():
	spawn_enemy()
	if _num_enemies <= 0:
		$Timer.stop()
	else:
		$Timer.wait_time = 1
		$Timer.start()
		
func spawn_enemy() -> void:
	var random_spawn_point = spawn_points[_rng.randi_range(0, spawn_points.size() - 1)]
	var random_enemy_res = _wave_res.enemy_resources[_rng.randi_range(0, _wave_res.enemy_resources.size() - 1)]
	
	var enemy = enemy_scene.instantiate()
	enemy.enemy_resource = random_enemy_res
	random_spawn_point.add_child(enemy)
	
	
	_num_enemies -= 1
	
