class_name InputComponent
extends Node


var input_horizontal: float = 0.0
var time_held: float = 0.0


func _process(delta: float) -> void:
	input_horizontal = Input.get_axis("left", "right")

	get_restart_input(delta)


func get_restart_input(delta: float) -> void:
	print(time_held)
	if not Input.is_action_pressed("restart"):
		time_held = 0
		return

	time_held += delta
	if time_held > 1:
		time_held = 0
		get_tree().reload_current_scene()


func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")


func get_jump_input_released() -> bool:
	return Input.is_action_just_released("jump")
