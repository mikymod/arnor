## Enemy idle
##
## The idle state of Enemy's state machine.
## This is the first state reached when is spawned.
extends State

export var enemy_path: NodePath
onready var enemy: RigidBody2D = get_node(enemy_path)

func enter(msg = {}):
	print("enemy enemy state")
	enemy.linear_velocity = Vector2.ZERO
	state_machine.transition_to("Move")
