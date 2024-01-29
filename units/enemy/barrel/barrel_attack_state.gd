extends State


@export var barrel: Barrel
@export var animation_player: AnimationPlayer
@export var timer: Timer

func enter() -> void:
	animation_player.play("attack")
	timer.wait_time = barrel.explosion_time
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	barrel.aoe_attack()
