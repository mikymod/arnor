extends State


@export var unit: Unit
@export var animation_player: AnimationPlayer
@export var nav_agent: NavigationAgent2D


func enter() -> void:
	animation_player.play("walk")
	nav_agent.max_speed = 350
	nav_agent.target_position = unit.target.global_position + Vector2(randf_range(-40, 40), randf_range(-40, 40))
	nav_agent.navigation_finished.connect(_on_navigation_finished)
	nav_agent.velocity_computed.connect(_on_velocity_computed)


func physics_update(_delta: float) -> void:
	var target_position = nav_agent.get_next_path_position()
	var direction = unit.global_position.direction_to(target_position)
	var new_velocity = direction * 100
	if nav_agent.avoidance_enabled:
		nav_agent.velocity = new_velocity
		unit.velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)


func exit() -> void:
	nav_agent.velocity_computed.disconnect(_on_velocity_computed)
	nav_agent.navigation_finished.disconnect(_on_navigation_finished)


func _on_navigation_finished() -> void:
	transitioned.emit("Idle")


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	unit.velocity = safe_velocity
	var collided = unit.move_and_slide()
