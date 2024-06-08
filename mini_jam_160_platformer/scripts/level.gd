extends Node2D


@export var initial_room: Room

var current_room: Room


func _ready() -> void:
	current_room = initial_room
	var room_children = current_room.get_children()
	for child in room_children:
		if child is RoomExit:
			child.player_exited_room.connect(_on_player_exited_room)


func load_new_room(new_scene: PackedScene, exit_direction: Globals.Directions) -> void:
	var new_room = new_scene.instantiate()
	if new_room is Room:
		new_room.previous_player_direction = exit_direction
		current_room.queue_free()
		add_child.call_deferred(new_room)
		current_room = new_room


func _on_player_exited_room(new_scene: PackedScene, exit_direction: Globals.Directions) -> void:
	load_new_room(new_scene, exit_direction)
