extends State

export var enemy_path: NodePath
onready var enemy: Enemy = get_node(enemy_path)

func enter(msg = {}) -> void:
	print("enemy dead state")
	enemy.queue_free()
