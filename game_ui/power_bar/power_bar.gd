extends Control

#@export var state: CardBoardState = preload("res://card_framework/card_board_state.tres")
@export var supply: Supply = preload("res://supplies/gold.tres")
@export var speed: float = 3

func _process(delta: float) -> void:
	supply.increase(delta * 3)
	$TextureProgressBar.value = supply.value

func _on_card_played(card: Card) -> void:
	var cost = card.card_resource.cost
	supply.decrease(cost * 10)

