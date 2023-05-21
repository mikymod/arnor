extends Control

func _on_new_game_button_pressed():
	SceneManager.load_map()
#	SceneManager.load_map_node()

func _on_exit_button_pressed():
	get_tree().quit()
