extends Control

@export var state: CardBoardState = preload("res://card_framework/card_board_state.tres")

@onready var _label: Label = $TextureRect/CenterContainer/Label

func _process(delta: float) -> void:
	_label.text = "%s/%s" % [state.current_power, state.max_power]

func restore_power() -> void:
	state.reset_power()

func _on_card_played(card: Card) -> void:
	var cost = card.card_resource.cost
	state.decrease_power(cost)

