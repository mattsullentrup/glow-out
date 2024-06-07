class_name State
extends Node


@warning_ignore("unused_signal")
signal state_changing(current, new_state_name)


func _enter() -> void:
	#print("Entering " + self.name)
	pass


func _exit() -> void:
	#print("Exiting " + self.name)
	#print("~~~~~~~~")
	pass


func _handle_input(_event) -> void:
	pass


func _update(_delta: float) -> void:
	pass


func _update_physics(_delta) -> void:
	pass
