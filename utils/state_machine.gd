class_name StateMachine
extends Node

# Path3D to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath()

@onready var state: State = get_node(initial_state)

var previous_state: State

var states: Dictionary = {}

func _ready() -> void:
	# Wait untill the parent emits ready signal
	# The states are children of the owner node so their `_ready()` callback will execute first.
	await owner.ready
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(_on_state_transitioned)
		else:
			push_warning("State machine contains child which is not State")
	state.enter()



func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func _on_state_transitioned(new_state_name: String) -> void:
	transition_to(new_state_name)

func transition_to(new_state_name: String) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != state:
			state.exit()
			new_state.enter()
			state = new_state
	else:
		push_warning("Called transition on a state that does not exist")
#
#func back_to_previous_state(msg: Dictionary = {}) -> void:
	#state.exit()
	#state = previous_state
	#state.enter(msg)
	#self.transitioned.emit(state.name)
