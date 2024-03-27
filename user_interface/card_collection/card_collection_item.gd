class_name CardCollectionItem
extends Control

var card: CardResource = preload("res://resources/cards/warrior.tres")

func _ready() -> void:
	$UnitThumb.texture = card.unit_thumb
