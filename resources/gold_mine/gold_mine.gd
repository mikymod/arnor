class_name GoldMine
extends Supply

@export var gold_resource: GatherResource = preload("res://resources/gold.tres")

func pop_resource() -> void:
	gold_resource.add(amount)

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

