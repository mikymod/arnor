extends Node2D

@export var turn_manager_resource: TurnManagerResource
@export var enemy_list: Array[PackedScene]
@export var waves: Array[int] # Number of enemies per wave

@onready var spawn_points: Array = $SpawnPoints.get_children()

var _current_wave: int = -1
var _num_enemies: int = 0
var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	turn_manager_resource.wave_phase_started.connect(_on_wave_phase_started)

func _on_wave_phase_started() -> void:
	_current_wave += 1
	if _current_wave >= waves.size():
		_current_wave = 0
		
	_num_enemies = waves[_current_wave]
	
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
	var random_enemy = enemy_list[_rng.randi_range(0, enemy_list.size() - 1)]
	var enemy = random_enemy.instantiate()
	random_spawn_point.add_child(enemy)
	_num_enemies -= 1
	
