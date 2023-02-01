class_name DeckResource
extends Resource

signal deck_depleted()
signal deck_restored()

export(Dictionary) var deck_list
export(PackedScene) var card_scene
export(Resource) var card_events

var deck: Array = []

func create_deck() -> void:
	for card in deck_list:
		var quantity = deck_list[card]
		for _i in range(quantity):
			var instance = card_scene.instance()
			instance.resource = card
			deck.append(instance)
	deck.shuffle()

func draw_card() -> void:
	var current = deck.pop_back()
	card_events.emit_signal("card_drawed", current)
	if deck.size() <= 0:
		emit_signal("deck_depleted")

func restore_deck(cards_to_restore: Array) -> void:
	deck.append_array(cards_to_restore)
	deck.shuffle()
	emit_signal("deck_restored")
