extends Control

##

@export var state: CardBoardState = preload("res://card_framework/card_board_state.tres")

func _process(delta: float) -> void:
	$MarginContainer/Label.text = str(state.deck_cards.size())

