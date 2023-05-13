extends Control

@export var encounter_events: EncounterEvents
@export var cards: Array[CardResource]

@onready var slots = [
	$HBoxContainer/RewardSlot1,
	$HBoxContainer/RewardSlot2,
	$HBoxContainer/RewardSlot3,
]

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	encounter_events.reward_phase_started.connect(_on_reward_phase_started)

func _on_reward_phase_started() -> void:
	for slot in slots:
		var index = _rng.randi_range(0, cards.size() - 1)
		slot.card_resource = cards[index]
		slot.set_skin()
		slot.set_data()
