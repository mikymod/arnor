extends Node2D

@export var encounter_events: EncounterEvents
@export var enemy_events: EnemyEvents
@export var enemy_list: Array[PackedScene]
@export var waves: Array[int] # Number of enemies per wave

@onready var spawn_points: Array = $SpawnPoints.get_children()

var _current_wave_count: int = -1
var _enemies_to_spawn: int = 0
var _rng = RandomNumberGenerator.new()
var _remaining_enemies_in_wave: int = 0

func _ready() -> void:
	encounter_events.wave_phase_started.connect(_on_wave_phase_started)
	enemy_events.enemy_dead.connect(_on_enemy_dead)

func _on_wave_phase_started() -> void:
	_current_wave_count += 1
	_enemies_to_spawn = waves[_current_wave_count]
	
	$Timer.one_shot = true
	$Timer.autostart = false
	$Timer.start()

func _on_Timer_timeout():
	spawn_enemy()
	if _enemies_to_spawn <= 0:
		$Timer.stop()
	else:
		$Timer.wait_time = 1
		$Timer.start()
		
func spawn_enemy() -> void:
	var random_spawn_point = spawn_points[_rng.randi_range(0, spawn_points.size() - 1)]
	var random_enemy = enemy_list[_rng.randi_range(0, enemy_list.size() - 1)]
	var enemy = random_enemy.instantiate()
	random_spawn_point.add_child(enemy)
	_enemies_to_spawn -= 1
	_remaining_enemies_in_wave += 1

func _on_enemy_dead() -> void:
	_remaining_enemies_in_wave -= 1
	if (_current_wave_count >= waves.size() - 1):
		encounter_events.reward_phase_started.emit()
		return
	if (_remaining_enemies_in_wave <= 0):
		encounter_events.wave_cleared.emit()
	
