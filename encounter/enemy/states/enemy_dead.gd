extends State

@export var enemy_path: NodePath
@onready var enemy: Enemy = get_node(enemy_path)

@export var sprite_path: NodePath
@onready var sprite: Sprite2D = get_node(sprite_path)

@export var animation_player_path: NodePath
@onready var animation_player: AnimationPlayer = get_node(animation_player_path)

func enter(msg = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_end)
	animation_player.play("Dead")
	sprite.visible = true

func _on_animation_end(_anim_name: String) -> void:
	sprite.visible = false
	animation_player.stop()
	enemy.enemy_events.enemy_dead.emit()
	enemy.queue_free()

