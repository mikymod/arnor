class_name RewardList
extends Control

@export var button_scene: PackedScene

const gold_reward_text: String = "%s gold"
var gold_reward_icon: Texture2D = preload("res://user_interface/textures/icons/Regular_01.png")

const exp_reward_text: String = "%s exp."
var exp_reward_icon: Texture2D = preload("res://user_interface/textures/icons/Regular_01.png")

func _ready() -> void:
	# FIXME: test, should be removed
	add_gold_reward(139)
	add_exp_reward(650)
	add_gold_reward(139)
	add_exp_reward(650)
	add_gold_reward(139)
	add_exp_reward(650)

func add_gold_reward(amount: int) -> void:
	var button = button_scene.instantiate() as RewardButton
	button.init(gold_reward_icon, gold_reward_text % amount)
	$VBoxContainer.add_child(button)

func add_exp_reward(amount: int) -> void:
	var button = button_scene.instantiate() as RewardButton
	button.init(exp_reward_icon, exp_reward_text % amount)
	$VBoxContainer.add_child(button)

func add_card_reward(card: CardResource) -> void:
	# TODO: manage this
	pass
