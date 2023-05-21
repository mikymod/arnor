extends Node2D

@export var encounter_events: EncounterEvents

@onready var _card_manager: CardManager = $CardManager
@onready var _reward_area: Control = $GameUI/RewardArea
@onready var _deck_label: Control = $GameUI/Cards/HBoxContainer/DeckIcon/MarginContainer/Label
@onready var _discard_label: Control = $GameUI/Cards/HBoxContainer/DiscardIcon/MarginContainer/Label
@onready var _exhaust_label: Control = $GameUI/Cards/HBoxContainer/ExhaustIcon/MarginContainer/Label

func _enter_tree() -> void:
	encounter_events.reward_phase_started.connect(_on_reward_phase_started)
	encounter_events.reward_selected.connect(_on_reward_selected)

func _exit_tree():
	encounter_events.reward_phase_started.disconnect(_on_reward_phase_started)
	encounter_events.reward_selected.disconnect(_on_reward_selected)

func _ready() -> void:
	# Disable reward area
	# The easiest way to stop processing a node is to remove it from the tree
	# (call remove_child() from its parent). This will make it invisible and stop
	# all processing, including physics.
	$GameUI.remove_child(_reward_area)

func _process(delta: float) -> void:
	_deck_label.text = str(_card_manager.deck.size())
	_discard_label.text = str(_card_manager.discard.size())
	_exhaust_label.text = str(_card_manager.exhaust.size())

func _on_reward_phase_started() -> void:
	$GameUI.add_child(_reward_area)
#	_reward_area.global_position = _reward_area_pos
	_reward_area.visible = true

func _on_reward_selected(_card) -> void:
	$GameUI.remove_child(_reward_area)
