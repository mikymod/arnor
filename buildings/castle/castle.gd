extends Building

func harm(amount: float) -> void:
	super.harm(amount)
	if (health <= 0):
		$DestroyedSprite2D.visible = true
		$BuildingSprite2D.visible = false
