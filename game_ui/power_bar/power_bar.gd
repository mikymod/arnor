extends Control

@export var state: CardBoardState = preload("res://card_framework/card_board_state.tres")
@export var speed: float = 3

var progress: float = state.current_power * 10

func _process(delta: float) -> void:
	progress += delta * 3
	$TextureProgressBar.value = progress
	state.current_power = progress / 10


func _on_card_played(card: Card) -> void:
	var cost = card.card_resource.cost
	state.decrease_power(cost)
	progress = state.current_power * 10
