class_name Room
extends Node2D


@export var initial_player_upwards_velocity: float = 200
@export_enum("northwest:-1", "northeast:1") var initial_player_upwards_direction: int

var exits: Array[RoomExit] = []
var player: Player
var offset: int = 16


func _ready() -> void:
	for node in get_children():
		if node is RoomExit:
			exits.append(node)


func setup_player(entry_door, exit_direction) -> void:
	player.velocity = Vector2.ZERO
	player.process_mode = Node.PROCESS_MODE_DISABLED

	match exit_direction:
		Globals.Directions.SOUTH:
			player.position.y = entry_door.position.y + offset
			player.position.x = entry_door.position.x
		Globals.Directions.NORTH:
			#player.velocity += Vector2(initial_player_upwards_direction, -1) * initial_player_upwards_velocity
			move_player.call_deferred(entry_door)
		Globals.Directions.EAST:
			player.position.x = entry_door.position.x + offset
		Globals.Directions.WEST:
			player.position.x = entry_door.position.x - offset

	player.velocity = Vector2.ZERO
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.reset_physics_interpolation()


func move_player(entry_door) -> void:
	var tween = create_tween()
	tween.tween_property(
			player, "position", $StartPosition.global_position, 0.4
			).from(Vector2(entry_door.position.x, entry_door.position.y - offset))
	await tween.finished
