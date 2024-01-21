class_name Unit
extends CharacterBody2D

#signal target_changed(target: Node2D)

enum UnitSpeed {
	SLOW = 50,
	MEDIUM = 100,
	FAST = 200,
}

enum UnitGroup {
	ALLIES,
	ENEMIES,
}

@export_group("Stats")
@export var health: float = 1000
@export var damage: float = 100
@export var attack_speed: float = 1
@export var speed: UnitSpeed = UnitSpeed.MEDIUM
@export var range: float = 0
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
		
var _units_in_range: Array[Unit] = []

func _ready() -> void:
	add_to_group(UnitGroup.keys()[group])

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		sprite.flip_h = velocity.x < 0
	
	if has_nearby_units():
		state_machine.transition_to("Attack")


func dps() -> float:
	return damage / attack_speed


func attack() -> void:
	var hostile_unit = get_hostile_unit()
	if hostile_unit == null:
		return
	hostile_unit.health -= damage
	if hostile_unit.health <= 0:
		_units_in_range.erase(hostile_unit)
		hostile_unit.die()


func die() -> void:
	var dead = dead_scene.instantiate()
	dead.global_position = global_position
	get_tree().root.add_child(dead)
	queue_free()


func get_hostile_unit() -> Unit:
	if _units_in_range.is_empty():
		return null
	return _units_in_range.filter(func(unit): return unit.health > 0).front()


func has_nearby_units() -> bool:
	return not _units_in_range.is_empty()

##
func add_to_units_in_range(unit: Unit, group: UnitGroup) -> void:
	if unit.is_in_group(UnitGroup.keys()[group]):
		_units_in_range.append(unit)

##
func remove_from_units_in_range(unit: Unit) -> void:
		_units_in_range.erase(unit)


func get_attack_direction() -> Vector2:
	var hostile_unit = get_hostile_unit()
	if hostile_unit == null:
		return Vector2.ZERO;

	var directions: Array[Vector2] = [
		Vector2.RIGHT,
		Vector2.LEFT,
		Vector2.UP,
		Vector2.DOWN,
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
