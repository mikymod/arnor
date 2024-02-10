extends Building


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	$BuildingSprite2D.play("default")

func destroy() -> void:
	$BuildingSprite2D.stop()
	$BuildingSprite2D.visible = false
	$DestroyedSprite2D.visible = true

func harm(amount: float) -> void:
	super.harm(amount)
	if health <= 0:
		destroy()

