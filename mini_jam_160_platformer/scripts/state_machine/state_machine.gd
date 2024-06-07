class_name StateMachine
extends Node


@export var initial_state: Node

var states: Dictionary = {}
var current_state: State = null
var previous_state: State = null


func _enter_tree() -> void:
	if initial_state == null:
		initial_state = get_child(0)

	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			initialize(child)
			continue

		push_error("Child" + child.name + " is not a State")

	change_state(null, initial_state.name)


func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state._handle_input(event)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state._update_physics(delta)


func initialize(state: State) -> void:
	state.connect("state_changing", _on_state_changing)


func change_state(source_state: State, new_state_name: String) -> void:
	var new_state: State = states.get(new_state_name.to_lower())
	if not new_state or current_state == new_state:
		return

	if current_state:
		current_state._exit()

	previous_state = source_state
	current_state = new_state

	current_state._enter()


func _on_state_changing(source_state: State, new_state_name: String) -> void:
	change_state(source_state, new_state_name)


func _on_gun_grapple_launched() -> void:
	change_state(current_state, "grapple")
