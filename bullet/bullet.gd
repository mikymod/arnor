class_name Bullet
extends Area2D

@export var resource: Resource; # Bullet Resource

var damage: float = 0

func _ready() -> void:
	$Sprite2D.texture = resource.texture

func _process(delta: float) -> void:
	global_position += Vector2.RIGHT * resource.velocity * delta;

func _on_Bullet_body_entered(body: Node):
	if (body.has_method('hit')):
		body.hit(damage)
	queue_free()


