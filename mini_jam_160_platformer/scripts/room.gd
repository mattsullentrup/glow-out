class_name Room
extends Node2D


@export var initial_player_velocity: float
@export var initial_player_position: Node2D
@export var exits: Array[RoomExit] = []

var player: Player
var offset: int = 24


func setup_player(entry_door, exit_direction) -> void:
	var new_position = entry_door.position + Globals.direction_pairs[exit_direction] * offset
	player.position = new_position
	player.set_physics_process(true)
	player.set_process(true)
	player.reset_physics_interpolation()

	for i in exits:
		var a = i.get_signal_connection_list("area_entered")
		print(a)
