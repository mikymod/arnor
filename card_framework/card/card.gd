class_name Card
extends Area2D

## A Card instance

signal hover_started(card: Card)
signal hover_stopped(card: Card)

@export var card_resource: CardResource
@export var player_resource: PlayerResource

@onready var _background_frame: Sprite2D = $BackgroundFrame
@onready var _foreground_frame: Sprite2D = $BackgroundFrame/ForegroundFrame
@onready var _cost_frame: Sprite2D = $CostFrame
@onready var _selected_frame: Sprite2D = $Selected
@onready var _cost_label: RichTextLabel = $CostFrame/CostLabel

var _hovered = false
var dragged = false

func _ready() -> void:
	var foreground = card_resource.unit_thumb.instantiate()
	_background_frame.add_child(foreground)
	set_data()

func _process(delta: float) -> void:
	if card_resource.cost > player_resource.get_mana_value():
		modulate = Color.DARK_GRAY
	else:
		modulate = Color.WHITE

func set_data() -> void:
	_cost_label.bbcode_enabled = true
	_cost_label.text = "[center]" + str(card_resource.cost) + "[/center]"


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

