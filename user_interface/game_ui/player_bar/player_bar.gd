# The PlayerBar class represents the UI control for displaying player information, such as gold, level, and experience.
class_name PlayerBar
extends Control

# The player variable holds the reference to the PlayerResource object.
@export var player: PlayerResource

# The xp_bar variable is a reference to the ProgressBar node that represents the experience bar in the UI.
@onready var xp_bar: ProgressBar = $ColorRect/XPBar

func _ready() -> void:
	player.gold_changed.connect(_on_gold_changed)
	player.exp_changed.connect(_on_xp_changed)
	player.level_reached.connect(_on_level_reached)
	_set_xp_bar_thresholds()
	update()

# The update function updates the UI elements with the current player information.
func update() -> void:
	$ColorRect/GoldLabel.text = str(player.gold)
	$ColorRect/LevelLabel.text = str(player.level)
	xp_bar.value = player.xp

# The add_gold function adds the specified amount of gold to the player's gold value.
func add_gold(amount: int) -> void:
	player.add_gold(amount)

# The add_exp function adds the specified amount of experience to the player's experience value.
func add_exp(amount: int) -> void:
	player.add_exp(amount)

# The _on_gold_changed function is called when the player's gold value changes.
# It triggers an update of the UI to reflect the new gold value.
func _on_gold_changed() -> void:
	update()

# The _on_xp_changed function is called when the player's experience value changes.
# It triggers an update of the UI to reflect the new experience value.
func _on_xp_changed() -> void:
	update()

# The _on_level_reached function is called when the player reaches a new level.
# It sets the new XP bar thresholds and triggers an update of the UI.
func _on_level_reached() -> void:
	_set_xp_bar_thresholds()
	update()

# The _set_xp_bar_thresholds function sets the minimum and maximum values of the XP bar based on the player's current and next level thresholds.
func _set_xp_bar_thresholds() -> void:
	xp_bar.min_value = player.prev_level_threshold()
	xp_bar.max_value = player.next_level_threshold()
