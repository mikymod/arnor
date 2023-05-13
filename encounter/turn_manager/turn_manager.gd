class_name TurnManager
extends Node2D

@export var encounter_events: EncounterEvents

@onready var timer: Timer = $Timer

func _ready() -> void:
	encounter_events.wave_cleared.connect(_on_wave_cleared)
	encounter_events.reward_selected.connect(_on_reward_selected)
	encounter_events.encounter_finished.connect(_on_encounter_finished)
	_start_turn()

func _on_wave_cleared() -> void:
	_start_turn()

func _on_reward_selected(_card) -> void:
	# TODO: this should be emitter after a transition
	encounter_events.encounter_finished.emit()

func _on_encounter_finished() -> void:
	# TODO: uncomment
	SceneManager.pop_scene()
	pass

func _start_turn() -> void:
	encounter_events.restore_phase_started.emit()
	encounter_events.draw_phase_started.emit()
	timer.start()
	
func _on_timer_timeout():
	encounter_events.wave_phase_started.emit()

func _on_Restore_Phase_button_down():
	encounter_events.restore_phase_started.emit()

func _on_Draw_Phase_button_down():
	encounter_events.draw_phase_started.emit()

func _on_Wave_Phase_button_down():
	encounter_events.wave_phase_started.emit()

func _on_Reward_Phase_button_down():
	encounter_events.reward_phase_started.emit()



