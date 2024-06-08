extends Node2D


@export var initial_room: Room

var current_room: Room


func _ready() -> void:
	$Player.position = $StartPosition.position

	current_room = initial_room
	var rooms = get_tree().get_nodes_in_group("rooms")
	for child: Room in rooms:
		if child is Room:
			for exit: RoomExit in child.exits:
				exit.player_exited_room.connect(_on_player_exited_room)
			child.position = Vector2.ZERO
			if child != initial_room:
				remove_child(child)


func load_new_room(new_scene: Room, exit_direction: Globals.Directions) -> void:
	var new_room = new_scene.instantiate()
	if new_room is Room:
		new_room.previous_player_direction = exit_direction
		current_room.queue_free()
		add_child.call_deferred(new_room)
		current_room = new_room


func _on_player_exited_room(new_room: Room, exit_direction: Globals.Directions) -> void:
	load_new_room(new_room, exit_direction)
