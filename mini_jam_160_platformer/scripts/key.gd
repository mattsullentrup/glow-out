class_name Key
extends Area2D


signal player_found_key


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	player_found_key.emit()
	queue_free()
