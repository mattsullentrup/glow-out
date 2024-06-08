extends Node2D


@export var initial_room: Room
@export var player: Player

var current_room: Room


func _ready() -> void:
	player.position = $StartPosition.position

	current_room = initial_room
	var rooms = get_tree().get_nodes_in_group("rooms")
	for child: Room in rooms:
		for exit: RoomExit in child.exits:
			exit.player_exited_room.connect(_on_player_exited_room)
		child.position = Vector2.ZERO
		if child != initial_room:
			remove_child(child)


func load_new_room(new_room: Room, entry_door: RoomExit, exit_direction: Globals.Directions) -> void:
	remove_child.call_deferred(current_room)
	add_child.call_deferred(new_room)

	new_room.previous_player_direction = exit_direction
	new_room.visible = true

	player.position = entry_door.position + Globals.direction_pairs[exit_direction] * 16
	player.set_physics_process(true)
	player.set_process(true)
	player.reset_physics_interpolation()

	current_room = new_room


func _on_player_exited_room(new_room: Room, entry_door: RoomExit, exit_direction: Globals.Directions) -> void:
	load_new_room(new_room, entry_door, exit_direction)
