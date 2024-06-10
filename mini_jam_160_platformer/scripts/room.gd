class_name Room
extends Node2D


var initial_player_upwards_velocity: float = 300

var exits: Array[RoomExit] = []
var offset: int = 16


func _ready() -> void:
	for node in get_children():
		if node is RoomExit:
			exits.append(node)


func setup_player(player: Player, is_playing_moving_up: bool, new_room_start_position: Marker2D) -> void:
	player.process_mode = Node.PROCESS_MODE_DISABLED

	if new_room_start_position != null:
		player.position = new_room_start_position.global_position

	if is_playing_moving_up:
		player.velocity = Vector2.UP * initial_player_upwards_velocity

	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.reset_physics_interpolation()
