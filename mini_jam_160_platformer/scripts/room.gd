class_name Room
extends Node2D


@export var initial_player_velocity: float
@export var initial_player_position: Node2D

var exits: Array[RoomExit] = []
var player: Player
var offset: int = 24


func _ready() -> void:
	for node in get_children():
		if node is RoomExit:
			exits.append(node)


func setup_player(entry_door, exit_direction) -> void:
	#player.velocity = Vector2.ZERO
	var new_position = entry_door.position + Globals.direction_pairs[exit_direction] * offset
	player.position = new_position
	player.set_physics_process(true)
	player.set_process(true)
	player.reset_physics_interpolation()

	if exit_direction == Globals.Directions.NORTH:
		player.velocity = Vector2(-1, -1) * 200
