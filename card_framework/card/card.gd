class_name Card
extends Area2D

## A Card instance

signal hover_started(card: Card)
signal hover_stopped(card: Card)

@export var card_resource: CardResource

@export var unit_scene: PackedScene

@onready var _background_frame: Sprite2D = $BackgroundFrame
@onready var _foreground_frame: Sprite2D = $ForegroundFrame
@onready var _name_frame: Sprite2D = $NameFrame
@onready var _cost_frame: Sprite2D = $CostFrame
@onready var _description_frame: Sprite2D = $DescriptionFrame
@onready var _rarity_frame: Sprite2D = $RarityFrame
@onready var _selected_frame: Sprite2D = $Selected
@onready var _name_label: RichTextLabel = $NameFrame/NameLabel
@onready var _cost_label: RichTextLabel = $CostFrame/CostLabel
@onready var _description_label: RichTextLabel = $DescriptionFrame/DescriptionLabel


var _hovered = false
var dragged = false

func _ready() -> void:
	set_data()

func set_data() -> void:
	_name_label.text = card_resource.name
	_cost_label.bbcode_enabled = true
	_cost_label.text = "[center]" + str(card_resource.cost) + "[/center]"
	_description_label.bbcode_enabled = true
	_description_label.text = "[center]"
	_description_label.text += card_resource.description + "\n"
	_description_label.text += "[/center]"

func hover() -> void:
	_selected_frame.visible = true

func unhover() -> void:
	_selected_frame.visible = false

func _on_Card_mouse_entered():
	_hovered = true
	hover_started.emit(self)

func _on_Card_mouse_exited():
	_hovered = false
	hover_stopped.emit(self)

#func start_drag() -> void:
	#dragged = true
	#change_opacity(0.2)
#
#func stop_drag() -> void:
	#dragged = false
	#change_opacity(1)
#
#func cancel_drag() -> void:
	#dragged = false
	#change_opacity(1)

func change_opacity(opacity: float) -> void:
	$BackgroundFrame.modulate.a = opacity
	$ForegroundFrame.modulate.a = opacity
	$NameFrame.modulate.a = opacity
	$CostFrame.modulate.a = opacity
	$DescriptionFrame.modulate.a = opacity
	$RarityFrame.modulate.a = opacity
	$Selected.modulate.a = opacity

