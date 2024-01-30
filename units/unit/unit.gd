class_name Unit
extends CharacterBody2D


## The possible values of unit's speed.
enum UnitSpeed {
	SLOW = 50,
	MEDIUM = 100,
	FAST = 200,
}

## The possible groups to which the unit belongs.
enum UnitGroup {
	ALLIES,
	ENEMIES,
}

@export_group("Stats")
## The health of the unit.
@export var health: float = 1000

## The damage dealt by the unit
@export var damage: float = 100

## The attack speed of the unit.
@export var attack_speed: float = 1

## The speed of the unit.
@export var speed: UnitSpeed = UnitSpeed.MEDIUM

## The range of interaction area.
@export var range: float = 0

## The possible groups to which the unit belongs.
@export var group: UnitGroup = UnitGroup.ALLIES

@export_group("Nodes")
@export var sprite: Sprite2D
@export var anim_player: AnimationPlayer
@export var agent: NavigationAgent2D
@export var state_machine: StateMachine
@export var attack_timer: Timer
@export var dead_scene: PackedScene = preload("res://units/dead/dead.tscn")

@export_group("Runtime")
@export var target: Node:
	set(node):
		target = node
	get:
		return target

## The other units in interaction range.
var _units_in_range: Array[Unit] = []

func _ready() -> void:
	add_to_group(UnitGroup.keys()[group])

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		sprite.flip_h = velocity.x < 0
	
	if has_nearby_units():
		state_machine.transition_to("Attack")

## Returns Damage Per Second dealt by the unit.
func dps() -> float:
	return damage / attack_speed

## Performs an attack to the hostile unit.
func attack() -> void:
	var hostile_unit = get_hostile_unit()
	if hostile_unit == null:
		return
	hostile_unit.health -= damage
	if hostile_unit.health <= 0:
		_units_in_range.erase(hostile_unit)
		hostile_unit.die()

## Performs an attack to all the units in range.
func aoe_attack() -> void:
	for unit in _units_in_range:
		unit.health -= damage
		if unit.health <= 0:
			_units_in_range.erase(unit)
			unit.die()

## Die.
func die() -> void:
	var dead = dead_scene.instantiate()
	dead.global_position = global_position
	get_tree().root.add_child(dead)
	queue_free()

## Returns the first unit that had entered the interaction range.
func get_hostile_unit() -> Unit:
	if _units_in_range.is_empty():
		return null
	return _units_in_range.filter(func(unit): return unit.health > 0).front()

## Returns true if the unit has some other units nearby. False otherwise.
func has_nearby_units() -> bool:
	return not _units_in_range.is_empty()

## Adds a unit to the list of those in the current unit's range
func add_to_units_in_range(unit: Unit) -> void:
	_units_in_range.append(unit)

## Removes a unit to the list of those in the current unit's range
func remove_from_units_in_range(unit: Unit) -> void:
	_units_in_range.erase(unit)

## Returns the attack direction of the current unit
func get_attack_direction() -> Vector2:
	var hostile_unit = get_hostile_unit()
	if hostile_unit == null:
		return Vector2.ZERO;

	var directions: Array[Vector2] = [
		Vector2.RIGHT,
		Vector2.LEFT,
		Vector2.UP,
		Vector2.DOWN,
		Vector2(1, 1), # up-right
		Vector2(-1, 1), # up-left
		Vector2(1, -1), # down-right
		Vector2(-1, -1), # down-left
	]
	
	var direction = global_position.direction_to(hostile_unit.global_position)
	
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
