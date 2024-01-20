extends State

@export var pawn: Pawn
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var attack_timer: Timer

func enter() -> void:
	attack_timer.timeout.connect(_on_attack_timer_timout)
	start_attack()


func exit() -> void:
	attack_timer.timeout.disconnect(_on_attack_timer_timout)


func start_attack() -> void:
	var attack_direction = pawn.get_attack_direction()
	var animation_name = "hammer"
	match attack_direction:
		Vector2.RIGHT:
			sprite.flip_h = false
		Vector2.LEFT:
			sprite.flip_h = true
		_:
			sprite.flip_h = false
	animation_player.play(animation_name)
	attack_timer.wait_time = pawn.attack_speed
	attack_timer.start()

func _on_attack_timer_timout() -> void:
	pawn.attack()
	if not pawn.has_nearby_units():
		transitioned.emit("Idle")
	else:
		start_attack()
