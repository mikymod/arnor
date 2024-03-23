class_name Spawner
extends Node

signal timeout(position: Vector2)

@export var start_time: float = 3
@export var spawn_time: float = 3

@onready var spawn_points: Array[Node] = $SpawnPoints.get_children()

## Starts the spawner
func start() -> void:
	$Timer.start(start_time)

## Stops the spawner
func stop() -> void:
	$Timer.stop()

func on_timer_timeout() -> void:
	var spawn_position: Vector2 = spawn_points.pick_random().global_position
	timeout.emit(spawn_position)
	$Timer.start(spawn_time)
