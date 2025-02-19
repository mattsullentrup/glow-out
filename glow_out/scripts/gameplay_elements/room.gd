class_name Room
extends Area2D


signal player_exited_room(new_room: Room, is_player_moving_up: bool)


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return

	var is_player_moving_up := false
	var player: Player = body as CharacterBody2D

	if player.get_last_motion().y < -0.5:
		is_player_moving_up = true

	player_exited_room.emit(self, is_player_moving_up)
