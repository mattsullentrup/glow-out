class_name RoomExit
extends Area2D


signal player_exited_room(new_room: Room, entry_door: RoomExit, exit_direction: Globals.Directions)

@export var room_one_exit_direction: Globals.Directions
@export var room_two_exit_direction: Globals.Directions

@export var room_one: Room
@export var room_two: Room


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return

	body.set_physics_process(false)
	body.set_process(false)
	set_physics_process(false)
	set_process(false)

	if Level.current_room == room_one:
		player_exited_room.emit(room_two, self, room_one_exit_direction)
	elif Level.current_room == room_two:
		player_exited_room.emit(room_one, self, room_two_exit_direction)
