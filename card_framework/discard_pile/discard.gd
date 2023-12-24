class_name Discard
extends Node

## The discard pile

## The array of cards discarded
var _cards: Array[Card] = []


# Adds card to discard pile
func discard_card(card: Card) -> void:
	# TODO: check if card has a parent
	_cards.append(card)


# Restores all cards in the deck from discard pile
func restore_all(deck: Deck) -> void:
	deck.restore(_cards)
	_cards.clear()


# Restores a single card in the discard pile
func restore_card(index: int) -> Card:
	return _cards.pop_at(index)



