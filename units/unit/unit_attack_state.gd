extends State

@export var unit: Unit
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var attack_timer: Timer

func enter() -> void:
	attack_timer.timeout.connect(_on_attack_timer_timout)
	start_attack()

func exit() -> void:
	attack_timer.timeout.disconnect(_on_attack_timer_timout)

func start_attack() -> void:
	var attack_direction = unit.get_attack_direction()
	var animation_name = "attack"
	match attack_direction:
		Vector2.RIGHT:
			sprite.flip_h = false
		Vector2(1, 1): # UP_RIGHT
			sprite.flip_h = false
			animation_name = "attack_up"
		Vector2.UP:
			animation_name = "attack_up"
		Vector2(-1, 1): # UP_LEFT
			sprite.flip_h = true
			animation_name = "attack_up"
		Vector2.LEFT:
			sprite.flip_h = true
		Vector2(-1, -1): # DOWN_LEFT
			sprite.flip_h = true
			animation_name = "attack_down"
		Vector2.DOWN:
			animation_name = "attack_down"
		Vector2(1, -1): # DOWN_RIGHT
			sprite.flip_h = false
			animation_name = "attack_down"
	animation_player.play(animation_name)
	attack_timer.wait_time = unit.attack_speed
	attack_timer.start()

func _on_attack_timer_timout() -> void:
	unit.attack()
	if not unit.has_nearby_units():
		transitioned.emit("Idle")
	else:
		start_attack()

