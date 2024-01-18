extends State

@export var animation_player: AnimationPlayer
@export var goblin: Enemy

func enter() -> void:
	animation_player.play("attack")
