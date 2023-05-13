class_name CardEvents
extends Resource

signal card_drawed(card: Card)    # Emitted when a card is drawed
signal card_played(card: Card)    # Emitted when a card is played
signal card_returned(card: Card)  # Emitted when a card is not played anymore and returns to hand
signal card_resolved(card: Card)  # Emitted when a card is played and all effects are resolved
signal card_discarded(card: Card) # Emitted when a card is discarded
signal card_exhausted(card: Card) # Emitted when a card is exhausted
