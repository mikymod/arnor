class_name Deck
extends Node2D

@export var deck_resource: DeckResource
@export var turn_manager_resource: TurnManagerResource
@export var hand_resource: HandResource
@export var reward_area_resource: RewardAreaResource
@export var deck_events: DeckEvents
@export var card_events: CardEvents
@export var card_scene: PackedScene

const min_cards_in_hand = 5

var deck: Array = []    # The array containing cards in deck
var discard: Array = [] # The array containing cards in discard pile
var exhaust: Array = [] # The array containing cards in exhaust pile

func _ready() -> void:
	deck_events.deck_draw_triggered.connect(_on_deck_draw_triggered)
	turn_manager_resource.draw_phase_started.connect(_on_draw_phase_started)
	reward_area_resource.reward_selected.connect(_on_reward_selected)
	card_events.card_discarded.connect(_on_card_discarded)
	card_events.card_exhausted.connect(_on_card_exhausted)
	create_deck()

func create_deck() -> void:
	for card in deck_resource.deck_list:
		var quantity = deck_resource.deck_list[card]
		for _i in range(quantity):
			var instance = card_scene.instantiate()
			instance.resource = card
			deck.append(instance)
	deck.shuffle()

func _process(_delta: float) -> void:
	$Control/HBoxContainer/DeckIcon/MarginContainer/Label.text = str(deck.size())
	$Control/HBoxContainer/DiscardIcon/MarginContainer/Label.text = str(discard.size())
	$Control/HBoxContainer/ExhaustIcon/MarginContainer/Label.text = str(exhaust.size())

# Draws a card from deck
func draw_card() -> void:
	var current = deck.pop_back()
	card_events.card_drawed.emit(current)
	if deck.size() <= 0:
		deck_events.deck_depleted.emit()
		restore_deck()

# Move cards in discard pile to deck 
func restore_deck() -> void:
	deck.append_array(discard)
	deck.shuffle()
	for _card in deck:
		_card.global_position = global_position
	discard.clear()
	deck_events.deck_restored.emit()

func _on_deck_draw_triggered() -> void:
	draw_card()

func _on_draw_phase_started() -> void:
	var num_cards_to_draw = max(min_cards_in_hand - hand_resource.cards.size(), 1)
	for _i in range(num_cards_to_draw):
		draw_card()

func _on_reward_selected(card_res):
	var instance = card_scene.instantiate()
	instance.resource = card_res
	discard.append(instance)

func _on_card_discarded(card: Card):
	card.global_position = global_position
	discard.append(card)

func _on_card_exhausted(card: Card) -> void:
	exhaust.append(card)
