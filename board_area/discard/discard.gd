class_name Discard
extends Node2D

export(Resource) var deck_resource
export(Resource) var card_events
export(Resource) var reward_area_resource
export(PackedScene) var card_scene

var cards: Array = []

func _ready() -> void:
	card_events.connect('card_played', self, '_on_card_played')
	deck_resource.connect('deck_depleted', self, '_on_deck_depleted')
	reward_area_resource.connect("reward_selected", self, "_on_reward_selected")

func _process(delta: float) -> void:
	$MarginContainer/Label.text = str(cards.size())

func _on_card_played(card):
	card.global_position = global_position
	cards.append(card)

func _on_deck_depleted():
	deck_resource.restore_deck(cards)
	cards.clear()

func _on_reward_selected(card_res):
	var instance = card_scene.instance()
	instance.resource = card_res
	cards.append(instance)


