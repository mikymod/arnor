extends State

export var enemy_path: NodePath
onready var enemy: Enemy = get_node(enemy_path)

export var sprite_path: NodePath
onready var sprite: Sprite = get_node(sprite_path)

export var animation_player_path: NodePath
onready var animation_player: AnimationPlayer = get_node(animation_player_path)

func enter(msg = {}) -> void:
	animation_player.connect("animation_finished", self, "_on_animation_end")
	animation_player.play("TakeHit")
	sprite.visible = true
	
	enemy.deal_damage(msg.damage)

func exit() -> void:
	sprite.visible = false
	animation_player.stop()
	animation_player.disconnect("animation_finished", self, "_on_animation_end")

func _on_animation_end(anim_name: String) -> void:
	if (enemy.health <= 0):
		state_machine.transition_to("Dead")
	else: 
		state_machine.back_to_previous_state()
