class_name CardEvents
extends Resource

signal card_drawed(card) # Emitted when a card is drawed
signal card_played(card) # Emitted when a card is played
signal card_returned(card) # Emitted when a card is not played anymore and returns to hand
signal card_resolved(card)  # Emitted when a card is played and all effects are resolved
signal card_discarded(card) # Emitted when a card is discarded
signal card_exhausted(card) # Emitted when a card is exhausted
