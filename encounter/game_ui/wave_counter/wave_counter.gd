extends Control

@export var encounter_events: EncounterEvents

var counter: int = 0

func _ready() -> void:
	encounter_events.wave_phase_started.connect(_on_wave_phase_started)

func _process(delta: float) -> void:
	$HBoxContainer/CenterContainer/Label.text = str(counter)

func _on_wave_phase_started() -> void:
	counter += 1
