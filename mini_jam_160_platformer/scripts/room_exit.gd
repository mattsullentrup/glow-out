class_name RoomExit
extends Area2D


signal player_exited_room(new_room: Room, door_exited: RoomExit, new_room_start_position: Marker2D)

@export var is_upwards_exit := false
@export var sister_exit: RoomExit
@export var new_room: Room
@export var new_room_start_position: Marker2D


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return

	player_exited_room.emit(new_room, self, new_room_start_position)
