extends State

@export var warrior: Warrior
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("idle")

func update(_delta: float) -> void:
	if warrior.target != null:
		var distance = absf(warrior.global_position.distance_to(warrior.target.global_position))
		if distance > 20: # FIXME: hardcoded
			transitioned.emit("Walk")
