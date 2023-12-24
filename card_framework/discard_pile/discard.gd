class_name Discard
extends Node

## The discard pile

@export var state: CardBoardState = preload("res://card_framework/card_board_state.tres")


# Adds card to discard pile
func discard_card(card: Card) -> void:
	# TODO: check if card has a parent
	state.discard_cards.append(card)


# Restores all cards in the deck from discard pile
func restore_all(deck: Deck) -> void:
	deck.restore(state.discard_cards)
	state.discard_cards.clear()


# Restores a single card in the discard pile
func restore_card(index: int) -> Card:
	return state.discard_cards.pop_at(index)



