## Enemy idle
##
## The idle state of Enemy's state machine.
## This is the first state reached when is spawned.
extends State

@export var enemy_path: NodePath
@onready var enemy: RigidBody2D = get_node(enemy_path)

@export var sprite_path: NodePath
@onready var sprite: Sprite2D = get_node(sprite_path)

@export var animation_player_path: NodePath
@onready var animation_player: AnimationPlayer = get_node(animation_player_path)

func enter(msg = {}):
	animation_player.play("Idle")
	sprite.visible = true
#	enemy.linear_velocity = Vector2.ZERO

func exit() -> void:
	sprite.visible = false
	animation_player.stop()

func _on_timer_timeout():
	state_machine.transition_to("Walk")

