class_name TurnManager
extends Node2D

@export var turn_manager_resource: Resource

func _on_Restore_Phase_button_down():
	turn_manager_resource.emit_signal("restore_phase_started")

func _on_Draw_Phase_button_down():
	turn_manager_resource.emit_signal("draw_phase_started")

func _on_Wave_Phase_button_down():
	turn_manager_resource.emit_signal("wave_phase_started")

func _on_Reward_Phase_button_down():
	turn_manager_resource.emit_signal("reward_phase_started")
