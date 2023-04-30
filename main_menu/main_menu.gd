extends Control

@export var first_scene: PackedScene = preload("res://map/map.tscn")

func _on_new_game_button_pressed():
	var map_scene = first_scene.instantiate()
	SceneManager.go_scene(map_scene)

func _on_exit_button_pressed():
	get_tree().quit()
