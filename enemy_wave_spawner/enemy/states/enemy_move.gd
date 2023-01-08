extends State

export var enemy_path: NodePath
onready var enemy: RigidBody2D = get_node(enemy_path)

func enter(msg = {}) -> void:
	print("enemy move state")
	enemy.reset_speed()

func exit() -> void:
	enemy.change_speed(0.0)

