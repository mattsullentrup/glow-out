class_name Room
extends Node2D


@export var initial_player_upwards_velocity: float = 200

var exits: Array[RoomExit] = []
var player: Player
var offset: int = 16


func _ready() -> void:
	for node in get_children():
		if node is RoomExit:
			exits.append(node)


func setup_player(door_exited: RoomExit, new_room_start_position: Marker2D) -> void:
	player.process_mode = Node.PROCESS_MODE_DISABLED

	if new_room_start_position != null:
		player.position = new_room_start_position.global_position

	if door_exited.is_upwards_exit:
		player.velocity = Vector2.UP * initial_player_upwards_velocity

	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.reset_physics_interpolation()
