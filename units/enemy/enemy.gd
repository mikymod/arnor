class_name Enemy
extends Unit

@onready var _state_machine: StateMachine = $StateMachine

var _units_in_range: Array[Unit] = []
var _unit_to_attack: Unit = null

func _process(delta: float) -> void:
	_unit_to_attack = get_unit_to_attack()
	if _unit_to_attack != null:
		var dir = get_attack_direction()
		_state_machine.transition_to("Attack")
		_unit_to_attack.visible = false

func get_unit_to_attack() -> Unit:
	if _units_in_range.is_empty():
		return null
	return _units_in_range.filter(func(unit): return unit.health > 0).front()

func get_attack_direction() -> Vector2:
	if _unit_to_attack == null:
		return Vector2.ZERO;

	var directions: Array[Vector2] = [
		Vector2.RIGHT,
		Vector2.LEFT,
		Vector2.UP,
		Vector2.DOWN,
	]
	
	var direction = global_position.direction_to(_unit_to_attack.global_position)
	
	var distances: Array[float] = [
		direction.distance_squared_to(Vector2.RIGHT),
		direction.distance_squared_to(Vector2.LEFT),
		direction.distance_squared_to(Vector2.UP),
		direction.distance_squared_to(Vector2.DOWN),
	]
	
	# Find index
	var min_distance = distances.min()
	var index = -1
	for v in distances:
		index += 1
		if v == min_distance:
			break
	
	return directions[index];


func _on_interaction_area_2d_body_entered(body: Node2D):
	var unit = body as Unit
	_units_in_range.append(unit)

func _on_interaction_area_2d_body_exited(body: Node2D):
	var unit = body as Unit
	_units_in_range.erase(unit)
