extends State

@export var unit: Unit
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("idle")

func update(_delta: float) -> void:
	if unit.target != null:
		var distance = absf(unit.global_position.distance_to(unit.target.global_position))
		if distance > 20: # FIXME: hardcoded
			transitioned.emit("Walk")
