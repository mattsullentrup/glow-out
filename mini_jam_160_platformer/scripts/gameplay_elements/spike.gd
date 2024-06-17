extends Area2D


signal player_collided_with_spike


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return

	player_collided_with_spike.emit()
