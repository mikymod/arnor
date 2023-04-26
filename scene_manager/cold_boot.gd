# Use this node to add the scene to the SceneManager automatically.
# This is mandatory if you want to cold boot a scene that is not the main scene.
@tool
extends Node

func _ready() -> void:
	SceneManager.add_cold_boot_scene(get_parent())



