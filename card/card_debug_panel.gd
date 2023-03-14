extends Control

@export var state_machine_path: NodePath
@onready var state_machine = get_node(state_machine_path)

func _process(delta: float) -> void:
	$Panel/HBoxContainer/StateValue.text = state_machine.state.name
