extends Control

@export var state: CardBoardState = preload("res://card_framework/card_board_state.tres")

@onready var _rects: Array[TextureRect] = [
	$HBoxContainer/TextureRect,
	$HBoxContainer/TextureRect2,
	$HBoxContainer/TextureRect3,
	$HBoxContainer/TextureRect4,
	$HBoxContainer/TextureRect5,
]

func _process(_delta: float) -> void:
	
	update_ui()

func update_ui() -> void:
	#for rect in _rects:
		#rect.modulate = rect.modulate.darkened(0.5)
	#for i in range(state.current_power):
		#_rects[i].modulate = _rects[i].modulate.lightened(0.5)
	pass

func _on_card_played(card: Card) -> void:
	var cost = card.card_resource.cost
	state.decrease_power(cost)
