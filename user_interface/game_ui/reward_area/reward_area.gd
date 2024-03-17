# This class represents the reward area in the game UI.
class_name RewardArea
extends Control

# A inner class that represents a reward that can be given to the player_res.
# It contains properties for the player_res's base XP, the difficulty modifier, a card resource, gold, and XP.
# The `calculate_xp_reward` function calculates the XP reward based on the player_res's base XP and the difficulty modifier.
# The `calculate_gold_reward` function calculates the gold reward based on a base reward value and the difficulty modifier.
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

@export var encounter_res: EncounterResource
@export var player_res: PlayerResource
@export var button_scene: PackedScene

const gold_reward_text: String = "%s gold"
var gold_reward_icon: Texture2D = preload ("res://user_interface/textures/icons/Regular_01.png")

const exp_reward_text: String = "%s exp."
var exp_reward_icon: Texture2D = preload ("res://user_interface/textures/icons/Regular_01.png")

var reward: Reward

func _ready() -> void:
	generate()

# Generates rewards for the player_res.
func generate() -> void:
	reward = Reward.new(player_res.base_xp, _difficulty_modifier())

	# Remove existing reward children
	for child in $RewardList/VBoxContainer.get_children():
		$RewardList/VBoxContainer.remove_child(child)

	# Add gold reward to list
	var gold_reward = button_scene.instantiate() as RewardButton
	gold_reward.init(gold_reward_icon, gold_reward_text % reward.gold)
	$RewardList/VBoxContainer.add_child(gold_reward)

	# Add XP reward to list
	var xp_reward = button_scene.instantiate() as RewardButton
	xp_reward.init(exp_reward_icon, exp_reward_text % reward.xp)
	$RewardList/VBoxContainer.add_child(xp_reward)

func _difficulty_modifier() -> float:
	return encounter_res.difficulty as float / player_res.level

# Takes the rewards and adds them to the player_res's XP and gold.
func take_rewards() -> void:
	player_res.add_xp(reward.xp)
	player_res.add_gold(reward.gold)
