class_name EnemyAttack
extends State

export var enemy_path: NodePath
onready var enemy = get_node(enemy_path)

export var sprite_path: NodePath
onready var sprite: Sprite = get_node(sprite_path)

export var animation_player_path: NodePath
onready var animation_player: AnimationPlayer = get_node(animation_player_path)

var _collides_with_tower = false

func enter(msg = {}) -> void:
	animation_player.connect("animation_finished", self, "_on_animation_end")
	animation_player.play("Attack")
	sprite.visible = true

func physics_update(_delta: float) -> void:
	_collides_with_tower = false
	for body in enemy.get_colliding_bodies():
		if body is Tower:
			_collides_with_tower = true
			break

func exit() -> void:
	sprite.visible = false
	animation_player.stop()
	animation_player.disconnect("animation_finished", self, "_on_animation_end")

func _on_animation_end(anim_name: String) -> void:
	if (enemy.health <= 0):
		state_machine.transition_to("Dead")
	elif _collides_with_tower: 
		state_machine.transition_to("Attack")
	else:
		state_machine.transition_to("Walk")
