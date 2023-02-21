class_name CardIdle
extends State

## Card idle
##
## The idle state of Card's state machine.
## This is the state reached when this card is in hand.

export(Resource) var card_events

export var card_path: NodePath
onready var card: Node2D = get_node(card_path)

var _playable = true

func enter(_msg := {}) -> void:
	card_events.connect("card_played", self, "_on_card_played")
	card_events.connect("card_resolved", self, "_on_card_resolved")
	card_events.connect("card_returned", self, "_on_card_resolved")

func handle_input(event: InputEvent) -> void:
	if not card.mouseover: return
	if not _playable: return
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			state_machine.transition_to('Play')

func exit() -> void:
	card_events.disconnect("card_played", self, "_on_card_played")
	card_events.disconnect("card_resolved", self, "_on_card_resolved")
	card_events.disconnect("card_returned", self, "_on_card_resolved")

func _on_card_played(card) -> void:
	_playable = false

func _on_card_resolved(card) -> void:

	_playable = true
