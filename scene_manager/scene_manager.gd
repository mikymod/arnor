extends Node

signal scene_loaded
signal scene_unloaded

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

# Clear the stack and go to a new scene
func go_scene(new_scene: Node) -> void:
	_clear()
	_add_scene(new_scene)

func _add_scene(scene: Node) -> void:
	_root.add_child(scene)
	scenes_stack.push_front(scene)

func _clear() -> void:
	for scene in scenes_stack:
		_root.remove_child(scene)
	scenes_stack.clear()

func add_cold_boot_scene(scene: Node) -> void:
	scenes_stack.push_front(scene)
