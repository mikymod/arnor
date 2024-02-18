class_name Unit
extends CharacterBody2D

signal spawned(unit: Unit)
signal health_changed(health: float)
signal died()


@export_group("Stats")
## The health of the unit.
@export var health: float = 1000

## The damage dealt by the unit
@export var damage: float = 100

## The attack speed of the unit.
@export var attack_speed: float = 1

## The speed of the unit.
enum UnitSpeed { SLOW = 50, MEDIUM = 100, FAST = 200 }
@export var speed: UnitSpeed = UnitSpeed.MEDIUM

## The range of interaction area.
@export var range: float = 0

@export_group("Nodes")
@export var sprite: Sprite2D
@export var anim_player: AnimationPlayer
@export var agent: NavigationAgent2D
@export var state_machine: StateMachine
@export var attack_timer: Timer
@export var dead_scene: PackedScene = preload("res://units/dead/dead.tscn")
@export var health_bar: HealthBar

@export_group("Runtime")
@export var target: Node:
	set(node):
		target = node
	get:
		return target
		

## The other units in interaction range.
var _units_in_range: Array[Unit] = []

## The building in interaction range
var _building: Building

func _ready() -> void:
	spawned.emit(self)

## Returns Damage Per Second dealt by the unit.
func dps() -> float:
	return damage / attack_speed

## Performs an attack to the hostile unit.
func attack() -> void:
	var hostile_unit = get_hostile_unit() if not _units_in_range.is_empty() else _building
	if hostile_unit == null:
		return
	if hostile_unit is Unit:
		hostile_unit.take_damage(damage)
		if hostile_unit.health <= 0:
			_units_in_range.erase(hostile_unit)
	else: # if building
		attack_building()

## Performs an attack to all the units in range.
func aoe_attack() -> void:
	for unit in _units_in_range:
		unit.take_damage(damage)
		if unit.health <= 0:
			_units_in_range.erase(unit)
	attack_building()

##
func attack_building() -> void:
	if _building == null: return
	_building.harm(damage)
	if _building.health <= 0:
		_building = null

##
func take_damage(amount: float) -> void:
	health -= amount
	health_changed.emit(health)
	if health <= 0:
		die()


## Die.
func die() -> void:
	died.emit()
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
	return not _units_in_range.is_empty() or _building != null

## Adds a unit to the list of those in the current unit's range
func add_to_units_in_range(unit: Unit) -> void:
	if unit == null: return
	if unit == self: return
	if get_parent() == unit.get_parent(): return
	_units_in_range.append(unit)
	state_machine.transition_to("Attack")


## Removes a unit to the list of those in the current unit's range
func remove_from_units_in_range(unit: Unit) -> void:
	if unit != null:
		_units_in_range.erase(unit)
	else:
		_units_in_range = _units_in_range.filter(func(u): return u != null)
	if not has_nearby_units():
		state_machine.transition_to("Idle")


##
func add_building_in_range(building: Building) -> void:
	if building == null: return
	if get_parent() == building.get_parent(): return
	_building = building
	state_machine.transition_to("Attack")

##
func remove_building_in_range(building: Building) -> void:
	if building == null: return
	_building = null


## Returns the attack direction of the current unit
func get_attack_direction() -> Vector2:
	var hostile_unit = get_hostile_unit()
	if hostile_unit == null:
		return Vector2.ZERO;

	var direction = global_position.direction_to(hostile_unit.global_position)

	var rounded = direction.round()
	
	return rounded;


func encounter_finished() -> void:
	state_machine.transition_to("Idle")
	target = null
