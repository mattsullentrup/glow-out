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


func setup_player(entry_door, exit_direction) -> void:
	player.process_mode = Node.PROCESS_MODE_DISABLED

	match exit_direction:
		Globals.Directions.SOUTH:
			player.position.y = entry_door.position.y + offset
			player.position.x = entry_door.position.x
		Globals.Directions.NORTH:
			player.position = Vector2(entry_door.position.x, entry_door.position.y - offset)
			player.velocity = Vector2.UP * initial_player_upwards_velocity
		Globals.Directions.EAST:
			player.position.x = entry_door.position.x + offset
		Globals.Directions.WEST:
			player.position.x = entry_door.position.x - offset

	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.reset_physics_interpolation()
