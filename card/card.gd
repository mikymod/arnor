class_name Card
extends Area2D

export var data: Resource

onready var _sprite: Sprite = $Sprite
onready var _name_label: RichTextLabel = $Sprite/NameLabel
onready var _cost_label: RichTextLabel = $Sprite/CostLabel
onready var _description_label: RichTextLabel = $Sprite/DescriptionLabel
onready var init_pos: Vector2 = global_position

func _ready() -> void:
	setup(data)

func setup(res: Resource) -> void:
	data = res
	_sprite.texture = data.background
	_name_label.text = data.name
	_cost_label.text = String(data.cost)
	_description_label.text = data.description






