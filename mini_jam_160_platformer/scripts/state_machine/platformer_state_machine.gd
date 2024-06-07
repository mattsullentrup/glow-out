class_name PlatformerStateMachine
extends StateMachine


@export var character: CharacterBody2D
@export var sprite: AnimatedSprite2D

#@onready var current_state_label: Label = $"../CurrentStateLabel"


func _enter_tree() -> void:
	super._enter_tree()


func _unhandled_input(event: InputEvent) -> void:
	super._unhandled_input(event)


#func _process(_delta: float) -> void:
	#current_state_label.text = current_state.name


func _physics_process(delta: float) -> void:
	super._physics_process(delta)


func initialize(state: State) -> void:
	super.initialize(state)
	state.sprite = sprite
	state.character = character


func change_state(source_state: State, new_state_name: String) -> void:
	super.change_state(source_state, new_state_name)


func _on_state_changing(source_state: State, new_state_name: String) -> void:
	super.change_state(source_state, new_state_name)


func _on_gun_grapple_launched() -> void:
	change_state(current_state, "grapple")
