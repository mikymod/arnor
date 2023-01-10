extends State

export var enemy_path: NodePath
onready var enemy: RigidBody2D = get_node(enemy_path)

export var sprite_path: NodePath
onready var sprite: Sprite = get_node(sprite_path)

export var animation_player_path: NodePath
onready var animation_player: AnimationPlayer = get_node(animation_player_path)

func enter(msg = {}) -> void:
	sprite.visible = true
	animation_player.play("Walk")
	enemy.reset_speed()

func exit() -> void:
	animation_player.stop()
	sprite.visible = false
	enemy.change_speed(0.0)
