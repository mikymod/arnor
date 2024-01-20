extends State

@export var goblin: Enemy
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var attack_timer: Timer

func enter() -> void:
	attack_timer.timeout.connect(_on_attack_timer_timout)	
	start_attack()


func start_attack() -> void:
	var attack_direction = goblin.get_attack_direction()
	var animation_name = "attack"
	match attack_direction:
		Vector2.RIGHT:
			sprite.flip_h = false
		Vector2.LEFT:
			sprite.flip_h = true
		Vector2.UP:
			animation_name = "attack_up"
		Vector2.DOWN:
			animation_name = "attack_down"
	animation_player.play(animation_name)
	
	attack_timer.wait_time = goblin.attack_speed
	attack_timer.start()


func update(_delta: float) -> void:
	if not goblin.has_nearby_units():
		transitioned.emit("Idle")

func _on_attack_timer_timout() -> void:
	goblin.attack()
	start_attack()
	


