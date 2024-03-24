class_name HealthBar
extends ProgressBar

##
func on_health_init(entity: Node2D) -> void:
	min_value = 0
	max_value = entity.health
	value = entity.health


##
func on_health_changed(health: float) -> void:
	value = health
	
func change_style(player: PlayerResource) -> void:
	var new_bg_stylebox = get_theme_stylebox("background").duplicate()
	new_bg_stylebox.bg_color = player.color.darkened(0.6)
	add_theme_stylebox_override("background", new_bg_stylebox)
	
	var new_fill_stylebox = get_theme_stylebox("fill").duplicate()
	new_fill_stylebox.bg_color = player.color
	add_theme_stylebox_override("fill", new_fill_stylebox)
