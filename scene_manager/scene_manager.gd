extends Node

signal scene_loaded
signal scene_unloaded

@export var first_scene: PackedScene = preload("res://map/map.tscn")

var scenes_stack: Array[Node] = []
var _root: Window
var _cold_boot: bool = false

func _ready() -> void:
	_root = get_tree().get_root()
	await _root.ready # await that all children are initialized
	
# Push a scene on top of the stack.
func push_scene(scene: Node) -> void:
	var previous = scenes_stack.front()
	if previous != null: 
		_root.remove_child(previous)
	_root.add_child(scene)
	scenes_stack.push_front(scene)

# Pop the scene contained in the head of the stack
func pop_scene() -> Node:
	var scene = scenes_stack.pop_front()
	_root.remove_child(scene)
	_root.add_child(scenes_stack.front())
	return scene

func _add_first_scene(scene: Node) -> void:
	_root.add_child(scene)
	scenes_stack.push_front(scene)

func add_cold_boot_scene(scene: Node) -> void:
	scenes_stack.push_front(scene)
