class_name StateMachine
extends Node

signal transitioned(state_name)

# Path3D to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath()

@onready var state = get_node(initial_state)

var previous_state: State

func _ready() -> void:
	# Wait untill the parent emits ready signal
	# The states are children of the owner node so their `_ready()` callback will execute first.
	await owner.ready

	for child in get_children():
		child.state_machine = self
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return

	state.exit()
	previous_state = state
	state = get_node(target_state_name)
	state.enter(msg)
	self.transitioned.emit(state.name)

func back_to_previous_state(msg: Dictionary = {}) -> void:
	state.exit()
	state = previous_state
	state.enter(msg)
	self.transitioned.emit(state.name)
