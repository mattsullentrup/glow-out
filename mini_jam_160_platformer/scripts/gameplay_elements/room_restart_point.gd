extends Area2D


@onready var marker_2d: Marker2D = $Marker2D


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	var player := body as Player
	player.room_restart_point = marker_2d.global_position
