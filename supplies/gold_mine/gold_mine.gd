class_name GoldMine
extends Area2D

## A source for gold.

@export var supply_scene: PackedScene

var _pawn: Pawn

## Activates the gold mine
func activate() -> void:
	$InactiveSprite.visible = false
	$ActiveSprite.visible = true

## Deactivates the gold mine
func deactivate() -> void:
	$InactiveSprite.visible = true
	$ActiveSprite.visible = false


## Destroys the gold mine.
## No supplies can be retrieved when it's destroyed.
func destroy() -> void:
	$DestroyedSprite.visible = true
	$InactiveSprite.visible = false
	$ActiveSprite.visible = false

## Returns the position to place a pawn
func get_gather_position() -> Node2D:
	return $GatherPosition

func get_supply_position() -> Node2D:
	return $SupplyPosition

## A callback invoked when a pawn entered the supply Area
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Pawn:
		activate()

func _on_gathering_bar_gathering_stopped() -> void:
	deactivate()

