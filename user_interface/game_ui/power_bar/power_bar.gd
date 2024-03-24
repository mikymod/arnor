# The PowerBar class represents a control node that displays and manages a power bar.
# It extends the Control class.

class_name PowerBar
extends Control

# The supply variable represents the resource supply for the power bar.
#@export var supply: Supply = preload ("res://supplies/gold.tres")

@export var player_resource: PlayerResource
# The speed variable represents the speed at which the power bar increases.
#@export var speed: float = 3

# The active variable represents whether the power bar is currently active or not.
# It is initially set to false.
#var active: bool = false

func _ready() -> void:
	$TextureProgressBar.value = player_resource.mana
	stop()

# The _process function is called every frame.
# If the power bar is not active, it returns early.
# Otherwise, it increases the supply value based on the delta time and the speed.
# It also updates the value of the TextureProgressBar.
func _process(delta: float) -> void:
	$TextureProgressBar.value = player_resource.mana

# The start function starts the power bar.
# It sets the active variable to true and enables the _process function.
func start() -> void:
	set_process(true)

# The stop function stops the power bar.
# It sets the active variable to false and disables the _process function.
func stop() -> void:
	set_process(false)

## The _on_card_played function is called when a card is played.
## It takes a Card object as a parameter.
## It decreases the supply value based on the cost of the card multiplied by 10.
#func _on_card_played(card: Card) -> void:
	#var cost = card.card_resource.cost
	#player_resource.decrease_mana(cost * 10)
