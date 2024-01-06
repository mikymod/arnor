class_name GoldMine
extends StaticBody2D

func activate() -> void:
	$InactiveSprite.visible = false
	$ActiveSprite.visible = true

func deactivate() -> void:
	$InactiveSprite.visible = true
	$ActiveSprite.visible = false

func get_gather_position() -> Node2D:
	return $GatherPosition


func _on_area_2d_body_entered(body):
	activate()


func _on_area_2d_body_exited(body):
	deactivate()
