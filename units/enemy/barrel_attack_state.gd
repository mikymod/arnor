extends State


@export var unit: Unit
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("attack")
