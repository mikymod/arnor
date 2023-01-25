extends State

export var enemy_path: NodePath
onready var enemy: Enemy = get_node(enemy_path)

export var sprite_path: NodePath
onready var sprite: Sprite = get_node(sprite_path)

export var animation_player_path: NodePath
onready var animation_player: AnimationPlayer = get_node(animation_player_path)

func enter(msg = {}) -> void:
	animation_player.connect("animation_finished", self, "_on_animation_end")
	animation_player.play("Dead")
	sprite.visible = true

func _on_animation_end(_anim_name: Sprite) -> void:
	sprite.visible = false
	animation_player.stop()
	animation_player.disconnect("animation_finished", self, "_on_animation_end")
	enemy.enemy_events.emit_signal("enemy_dead")
	enemy.queue_free()

