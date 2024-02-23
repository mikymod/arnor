extends Building

func harm(amount: float) -> void:
	super.harm(amount)
	if (health <= 0):
		$DestroyedSprite2D.visible = true
		$BuildingSprite2D.visible = false

func enable_spawn_area() -> void:
	$Area2D/NinePatchRect.visible = true

func disable_spawn_area() -> void:
	$Area2D/NinePatchRect.visible = false
