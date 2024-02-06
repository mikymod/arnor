extends Building


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")

func destroy() -> void:
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.visible = false
	$DestroyedSprite2D.visible = true

