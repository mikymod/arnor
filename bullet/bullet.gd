class_name Bullet
extends Area2D

export(Resource) var resource; # Bullet Resource

func _ready() -> void:
	$Sprite.texture = resource.texture

func _process(delta: float) -> void:
	global_position += Vector2.RIGHT * resource.velocity * delta;

func _on_Bullet_body_entered(body: Node):
	if (body.is_in_group("enemies")):
		body.hit(resource.damage)
	queue_free()


	
