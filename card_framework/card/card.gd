class_name Card
extends Area2D

## A Card instance

signal hover_started(card: Card)
signal hover_stopped(card: Card)

@export var card_resource: CardResource
@export var unit_scene: PackedScene

@onready var _background_frame: Sprite2D = $BackgroundFrame
@onready var _foreground_frame: Sprite2D = $BackgroundFrame/ForegroundFrame
#@onready var _name_frame: Sprite2D = $NameFrame
@onready var _cost_frame: Sprite2D = $CostFrame
#@onready var _description_frame: Sprite2D = $DescriptionFrame
#@onready var _rarity_frame: Sprite2D = $RarityFrame
@onready var _selected_frame: Sprite2D = $Selected
#@onready var _name_label: RichTextLabel = $NameFrame/NameLabel
@onready var _cost_label: RichTextLabel = $CostFrame/CostLabel
#@onready var _description_label: RichTextLabel = $DescriptionFrame/DescriptionLabel


var _hovered = false
var dragged = false

func _ready() -> void:
	set_data()

func set_data() -> void:
	_cost_label.bbcode_enabled = true
	_cost_label.text = "[center]" + str(card_resource.cost) + "[/center]"
	unit_scene = card_resource.unit_scene

func hover() -> void:
	_selected_frame.visible = true

func unhover() -> void:
	_selected_frame.visible = false

func _on_Card_mouse_entered():
	_hovered = true
	hover_started.emit(self)
	hover()

func _on_Card_mouse_exited():
	_hovered = false
	hover_stopped.emit(self)
	unhover()

func change_opacity(opacity: float) -> void:
	$BackgroundFrame.modulate.a = opacity
	$CostFrame.modulate.a = opacity
	$Selected.modulate.a = opacity

