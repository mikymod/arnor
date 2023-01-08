extends State

export var enemy_path: NodePath
onready var enemy: Enemy = get_node(enemy_path)

func enter(msg = {}) -> void:
	print("enemy hit state")
	enemy.deal_damage(msg.damage)
	if (enemy.health <= 0):
		state_machine.transition_to("Dead")
	else: 
		state_machine.back_to_previous_state()
