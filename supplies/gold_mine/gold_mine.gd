class_name GoldMine
extends Area2D

## A source for gold.

@export var supply_scene: PackedScene

@onready var _gathering_bar: GatheringBar = $GatheringBar

var _pawn: Pawn

## Activates the gold mine
func activate() -> void:
	$InactiveSprite.visible = false
	$ActiveSprite.visible = true
	_gathering_bar.start()

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

## A callback invoked when a pawn entered the supply Area
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Pawn:
		_pawn = body as Pawn
		_gathering_bar.gathering_stopped.connect(_pawn.on_gathering_timeout)
		activate()

func _on_gathering_bar_gathering_stopped():
	var supply = supply_scene.instantiate()
	supply.position = $SupplyPosition.position
	add_child(supply)
	_pawn.player_resource.increase_mana(10)
	_gathering_bar.gathering_stopped.disconnect(_pawn.on_gathering_timeout)
	deactivate()
	_pawn = null
