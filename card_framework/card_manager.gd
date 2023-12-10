class_name CardManager
extends Node2D

#@export var deck_resource: DeckResource = preload("res://card_framework/resources/deck.tres")
@export var encounter_events: EncounterEvents = preload("res://encounter/encounter_events.tres")
#@export var deck_events: DeckEvents = preload("res://card_framework/deck/deck_events.tres")
@export var card_events: CardEvents = preload("res://card_framework/card/card_events.tres")

@export var card_scene: PackedScene = preload("res://card_framework/card/card.tscn")

@onready var deck_node: Marker2D = $Deck
@onready var hand_node: Marker2D = $Hand
@onready var discard_node: Marker2D = $Discard
@onready var exhaust_node: Marker2D = $Exhaust

const min_cards_in_hand: int = 5

var deck: Array[Card] = []    # The array containing cards in deck
var hand: Array[Card] = []    # The array containing cards in hand
var discard: Array[Card] = [] # The array containing cards in discard pile
var exhaust: Array[Card] = [] # The array containing cards in exhaust pile

func _ready() -> void:
	#deck_events.deck_draw_triggered.connect(_on_deck_draw_triggered)
	#encounter_events.draw_phase_started.connect(_on_draw_phase_started)
	#encounter_events.reward_selected.connect(_on_reward_selected)
	card_events.card_resolved.connect(_on_card_resolved)
	card_events.card_discarded.connect(_on_card_discarded)
	card_events.card_exhausted.connect(_on_card_exhausted)
	#create_deck()

##
#func create_deck() -> void:
	#for card in deck_resource.deck_list:
		#var quantity = deck_resource.deck_list[card]
		#for _i in range(quantity):
			#var instance = card_scene.instantiate()
			#instance.card_resource = card
			#deck.append(instance)
	#deck.shuffle()

## Draws a card from deck and put it in hand
#func draw_card() -> void:
	#if deck.size() <= 0:
		#restore_deck()
	#
	#var current = deck.pop_back()
	#hand_node.add_child(current)
	#hand.append(current)
	#current.state_machine.transition_to("Draw")
	#_reposition()
	#if deck.size() <= 0:
		#deck_events.deck_depleted.emit()
		#restore_deck()

## Move cards in discard pile to deck 
#func restore_deck() -> void:
	#deck.append_array(discard)
	#deck.shuffle()
##	for _card in deck:
##		_card.global_position = global_position
	#discard.clear()
	#deck_events.deck_restored.emit()
#
##
#func _on_deck_draw_triggered() -> void:
	#draw_card()
#
##
#func _on_draw_phase_started() -> void:
	#var num_cards_to_draw = max(min_cards_in_hand - hand.size(), 1)
	#for _i in range(num_cards_to_draw):
		#draw_card()

#
func _on_card_resolved(card: Card):
	card.get_parent().remove_child(card)
	hand.erase(card)
	var new_pos: Vector2
	if card.card_resource.exhaust:
		exhaust.append(card)
		new_pos = exhaust_node.global_position
	else:
		discard.append(card)
		new_pos = discard_node.global_position
	card.global_position = new_pos
	_reposition()

#
func _on_card_discarded(card: Card):
	card.get_parent().remove_child(card)
	discard.append(card)
	card.global_position = discard_node.global_position

#
func _on_card_exhausted(card: Card) -> void:
	card.get_parent().remove_child(card)
	exhaust.append(card)
	card.global_position = exhaust_node.global_position

## Adds new card to deck resource
#func _on_reward_selected(card_res: CardResource):
	#deck_resource.add_card(card_res)

func _reposition():
	var positions = _generate_positions(hand_node.global_position, 214, hand.size())
	for i in range(hand.size()):
		hand[i].init_pos = positions[i]

func _generate_positions(center: Vector2, offset: int, num_card: int) -> Array:
	var positions = []
	var first_pos_x = 0.0
	if num_card % 2 == 0:
		first_pos_x = center.x - offset * 0.5 - offset * (num_card - 1) / 2.0
	if num_card % 2 == 1:
		first_pos_x = center.x - (offset * (num_card - 1) / 2.0)
	for i in range(num_card):
		positions.append(Vector2(first_pos_x + offset * i, center.y));
	return positions
