class_name RewardArea
extends Control

class Reward:
	var player_base_xp: int
	var difficulty_modifier: float
	
	var card: CardResource
	var gold: int = 0
	var xp: int = 0
	
	func _init(player_base_xp: int, difficulty_modifier: float):
		#self.card = card
		self.player_base_xp = player_base_xp
		self.difficulty_modifier = difficulty_modifier
		self.gold = calculate_gold_reward()
		self.xp = calculate_xp_reward()

	func calculate_xp_reward() -> float:
		return ceil(player_base_xp * difficulty_modifier)

	func calculate_gold_reward() -> float:
		var base_reward = 100
		return ceil(base_reward * difficulty_modifier)

@export var encounter: EncounterResource
@export var player: PlayerResource
@export var button_scene: PackedScene

const gold_reward_text: String = "%s gold"
var gold_reward_icon: Texture2D = preload("res://user_interface/textures/icons/Regular_01.png")

const exp_reward_text: String = "%s exp."
var exp_reward_icon: Texture2D = preload("res://user_interface/textures/icons/Regular_01.png")

var reward: Reward

func _ready() -> void:
	generate()

func generate() -> void:
	reward = Reward.new(player.base_xp, _difficulty_modifier())

	for child in $RewardList/VBoxContainer.get_children():
		$RewardList/VBoxContainer.remove_child(child)
	add_gold_reward()
	add_exp_reward()
	
func calculate_exp_reward() -> float:
	var reward = ceil(player.base_xp * _difficulty_modifier())
	return reward

func calculate_gold_reward() -> float:
	var base_reward = 100
	var reward = ceil(base_reward * _difficulty_modifier())
	return reward

func add_gold_reward() -> void:
	var button = button_scene.instantiate() as RewardButton
	button.init(gold_reward_icon, gold_reward_text % reward.gold)
	$RewardList/VBoxContainer.add_child(button)

func add_exp_reward() -> void:
	var button = button_scene.instantiate() as RewardButton
	button.init(exp_reward_icon, exp_reward_text % reward.xp)
	$RewardList/VBoxContainer.add_child(button)

func _difficulty_modifier() -> float:
	return encounter.difficulty as float / player.level

func take_rewards() -> void:
	pass
	
