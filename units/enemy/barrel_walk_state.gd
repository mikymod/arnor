extends State


@export var unit: Unit
@export var animation_player: AnimationPlayer
@export var nav_agent: NavigationAgent2D

func enter() -> void:
	animation_player.play("walk")
	nav_agent.max_speed = 350
	nav_agent.target_position = unit.target.global_position + Vector2(randf_range(-40, 40), randf_range(-40, 40))

func physics_update(_delta: float) -> void:
	var target_position = nav_agent.get_next_path_position()
	var direction = unit.global_position.direction_to(target_position)
	var new_velocity = direction * 100
	if nav_agent.avoidance_enabled:
		nav_agent.velocity = new_velocity
		unit.velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	unit.velocity = safe_velocity
	var collided = unit.move_and_slide()
	
func _on_interaction_body_entered(body: Node2D) -> void:
	transitioned.emit("Attack")
