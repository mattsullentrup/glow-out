class_name RoomExit
extends Area2D


signal player_exited_room(new_room: Room, door_exited: RoomExit, new_room_start_position: Marker2D)

@export var is_upwards_exit := false
@export var new_room_one: Room
@export var new_room_two: Room
#@export var new_room_start_position: Marker2D


func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, local_shape_index: int) -> void:
	var new_room: Room
	if local_shape_index == 0:
		new_room = new_room_one
	elif(local_shape_index == 1):
		new_room = new_room_two

	var start_position = get_child(local_shape_index).get_child(0)
	player_exited_room.emit(new_room, self, start_position)
