extends Node

signal scene_loaded
signal scene_unloaded

var main_menu_scene: PackedScene = preload("res://main_menu/main_menu.tscn")
var map_scene: PackedScene = preload("res://map/map.tscn")
var encounter_scene: PackedScene = preload("res://encounter/encounter.tscn")
var map_node_scene: PackedScene = preload("res://map/map_node/map_node.tscn")

var _scenes_stack: Array[Node] = []
var _root: Window
var _world: Node2D
var _gui: Control

func _ready() -> void:
	_root = get_tree().get_root()
	_world = _root.get_node("Main/World")
	_gui = _root.get_node("Main/GUI")
	await _root.ready # await that all children are initialized

func load_main_menu() -> void:
	var scene = main_menu_scene.instantiate()
	push_scene(scene)

func load_map() -> void:
	var scene = map_scene.instantiate()
	push_scene(scene)

func load_map_node() -> void:
	var scene = map_node_scene.instantiate()
	push_scene(scene)
	
# Push a scene on top of the stack
func push_scene(scene: Node) -> void:
	if _scenes_stack.size() > 0:
		var previous = _scenes_stack.front()
		_remove_scene_from_tree(previous)
	_scenes_stack.push_front(scene)
	_add_scene_to_tree(scene)

# Pop current scene. Activate the previous one if there's any.
func pop_scene() -> void:
	var scene = _scenes_stack.pop_front()
	_remove_scene_from_tree(scene)
	if _scenes_stack.size() > 0:
		scene = _scenes_stack.front()
		_add_scene_to_tree(scene)

# Clear the stack and go to a new scene
func go_scene(new_scene: Node) -> void:
	_clear()
	_add_scene_to_tree(new_scene)

# Add a Node to the scene tree
func _add_scene_to_tree(scene: Node) -> void:
	if scene is Control:
		_gui.add_child(scene)
	else:
		_world.add_child(scene)

# Remove a node from the scene tree
func _remove_scene_from_tree(scene: Node) -> void:
	if scene is Control:
		_gui.remove_child(scene)
	else:
		_world.remove_child(scene)

func _clear() -> void:
	for scene in _scenes_stack:
		_remove_scene_from_tree(scene)
		scene.queue_free()
	_scenes_stack.clear()
