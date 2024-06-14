extends Area2D


var camera: Camera2D


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return

	camera.global_position = global_position
	camera.reset_physics_interpolation()
