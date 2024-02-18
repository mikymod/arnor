extends Node2D

signal unit_spawned()

@export var parent: Node2D
@export var destination: Node2D
@export var start_time: float = 3
@export var spawn_time: float = 3
@export var units: Array[PackedScene]
@export var encounter: Encounter

#enum WaveType { easy, normal, hard, deadly }

@onready var player_area: PlayerArea = parent

## Starts the spawner
func start() -> void:
	$Timer.start(start_time)

## Stops the spawner
func stop() -> void:
	$Timer.stop()

## Spawns a unit
func spawn() -> void:
	$Timer.start(spawn_time)
	if units.is_empty(): return
	var unit: Unit = units.pick_random().instantiate()
	unit.global_position = $SpawnPoint.global_position
	unit.target = destination
	unit.health_bar.change_style(player_area)
	
	parent.add_child(unit)
	unit_spawned.emit()
	encounter.finished.connect(unit.die)
	encounter.failed.connect(unit.encounter_finished)
