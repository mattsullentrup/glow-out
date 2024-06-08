class_name RoomExit
extends Area2D


signal player_exited_room(new_room: Room, entry_door: RoomExit, exit_direction: Globals.Directions)

@export var exit_direction: Globals.Directions
@export var new_room: Room
@export var new_door: RoomExit


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return

	body.set_physics_process(false)
	body.set_process(false)
	set_physics_process(false)
	set_process(false)
	player_exited_room.emit(new_room, new_door, exit_direction)
