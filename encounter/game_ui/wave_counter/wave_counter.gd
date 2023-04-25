extends Control

@export var turn_manager_resource: Resource

var counter: int = 0

func _ready() -> void:
	turn_manager_resource.wave_phase_started.connect(_on_wave_phase_started)

func _process(delta: float) -> void:
	$HBoxContainer/CenterContainer/Label.text = str(counter)

func _on_wave_phase_started() -> void:
	counter += 1
