extends Node2D

export(Resource) var turn_manager_resource

export(Array, Resource) var cards

onready var slots = [
	$MarginContainer/CenterContainer/HBoxContainer/RewardSlot1,
	$MarginContainer/CenterContainer/HBoxContainer/RewardSlot2,
	$MarginContainer/CenterContainer/HBoxContainer/RewardSlot3,
]

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	turn_manager_resource.connect("reward_phase_started", self, "_on_reward_phase_started")

func _on_reward_phase_started() -> void:
	print("_on_reward_phase_started")
	for slot in slots:
		var index = _rng.randi_range(0, cards.size() - 1)
		slot.card_resource = cards[index]
		if slot.has_method("change_skin"):
			slot.change_skin()
