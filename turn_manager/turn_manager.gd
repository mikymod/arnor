class_name TurnManager
extends Node2D

@export var turn_manager_resource: Resource

func _on_Restore_Phase_button_down():
	turn_manager_resource.restore_phase_started.emit()

func _on_Draw_Phase_button_down():
	turn_manager_resource.draw_phase_started.emit()

func _on_Wave_Phase_button_down():
	turn_manager_resource.wave_phase_started.emit()

func _on_Reward_Phase_button_down():
	turn_manager_resource.reward_phase_started.emit()
