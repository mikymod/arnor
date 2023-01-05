class_name Deck
extends Node2D

export(Resource) var deck_resource
export(Resource) var turn_manager_resource

func _ready() -> void:
	deck_resource.connect('deck_restored', self, '_on_deck_restored')
	turn_manager_resource.connect('draw_phase_started', self, '_on_draw_phase_started')
	deck_resource.create_deck()

func _process(delta: float) -> void:
	$MarginContainer/Label.text = str(deck_resource.deck.size())
	
func draw_card() -> void:
	deck_resource.draw_card()

func _on_deck_restored():
	for _card in deck_resource.deck:
		_card.global_position = global_position

func _on_draw_phase_started() -> void:
	var num_cards_to_draw = min(deck_resource.deck_list.size(), 4)
	for _i in range(num_cards_to_draw):
		deck_resource.draw_card()
