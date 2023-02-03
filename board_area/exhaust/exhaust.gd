extends Control

export(Resource) var card_events

var cards: Array = []

func _ready():
	card_events.connect('card_exhausted', self, '_on_card_exhausted')

func _process(delta: float) -> void:
	$MarginContainer/Label.text = str(cards.size())

func _on_card_exhausted(card: Card) -> void:
	cards.append(card)
