class_name LevelExit
extends Area2D


signal player_exiting_level


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	#if body.has_key:
		#player_exiting_level.emit()
	player_exiting_level.emit()
