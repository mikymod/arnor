extends Control

export(Resource) var turn_manager_resource

var counter: int = 0

func _ready() -> void:
	turn_manager_resource.connect("wave_phase_started", self, "_on_wave_phase_started")

func _process(delta: float) -> void:
	$HBoxContainer/CenterContainer/Label.text = str(counter)

func _on_wave_phase_started() -> void:
	counter += 1
