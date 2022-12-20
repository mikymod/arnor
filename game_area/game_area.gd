class_name GameArea
extends Area2D

func _on_GameArea_area_entered(area: Node):
	if area is Card:
		area.playable = true

func _on_GameArea_area_exited(area: Node):
	if area is Card:
		area.playable = false
