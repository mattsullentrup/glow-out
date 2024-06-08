class_name RoomExit
extends Area2D


signal player_exited_room(room: Room)

@export var exit_direction: Globals.Directions
@export var new_room: Room

#var is_player_entering_room: bool = true


func _on_body_entered(body: Node2D) -> void:
	#if not body is Player or is_player_entering_room:
	if not body is Player:
		return

	player_exited_room.emit(new_room, exit_direction)
	body.set_physics_process(false)
	body.set_process(false)
	set_physics_process(false)
