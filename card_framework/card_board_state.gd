class_name CardBoardState
extends Resource

#signal power_restored()
#signal power_depleted()
#signal max_power_changed(num_power)
#
### The currency to be paid for playing cards
#@export var current_power: float = 50
#
### The maximum value of power
#@export var max_power: float = 100

## The cards in deck
var deck_cards: Array[Card] = []

## The cards in hand
var hand_cards: Array[Card] = []

## The cards discarded
var discard_cards: Array[Card] = []

## The cards exhausted
var exhaust_cards: Array[Card] = []


### Sets power to max value
#func reset_power() -> void:
	#current_power = max_power
	#power_restored.emit()


### Decreases current power by a specific amount
#func decrease_power(amount: float) -> void:
	#current_power -= amount
	#if current_power <= 0:
		#current_power = 0
		#power_depleted.emit()
#
#
### Increases current power by a specific amount
#func increase_power(amount: float) -> void:
	#current_power += amount
	#if current_power >= max_power:
		#current_power = max_power
#
#
### Increase max power by a specific amount
#func increase_max_power(amount: int) -> void:
	#max_power += amount
	#max_power_changed.emit(max_power)
#
#
### Decrease max power by a specific amount
#func decrease_max_power(amount: int) -> void:
	#max_power -= amount
	#max_power_changed.emit(max_power)
