class_name GoldMine
extends SupplySource

## A source for gold.

## Activates the gold mine
func activate() -> void:
	$InactiveSprite.visible = false
	$ActiveSprite.visible = true

## Deactivates the gold mine
func deactivate() -> void:
	$InactiveSprite.visible = true
	$ActiveSprite.visible = false

## Returns the position to place a pawn
func get_gather_position() -> Node2D:
	return $GatherPosition

## A callback invoked when a pawn entered the supply Area
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Pawn:
		activate()

## A callback invoked when a pawn exited the supply area
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Pawn:
		deactivate()

