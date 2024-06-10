class_name Level
extends Node2D


@export var initial_room: Room
@export var player: Player
@export var level_exit: LevelExit
@export var key: Key
@export var level_start_position: Marker2D
@export var camera: Camera2D

static var current_room: Room
var door_last_exited: RoomExit


func _ready() -> void:
	player.position = level_start_position.global_position
	player.reset_physics_interpolation()
	player.player_collided_with_spike.connect(_on_player_collided_with_spike)

	level_exit.player_exiting_level.connect(LevelManager._on_player_exiting_level)

	current_room = initial_room

	for child: Room in get_tree().get_nodes_in_group("rooms"):
		child.player = player
		if child != initial_room:
			toggle_room(child, false)
		else:
			camera.position = initial_room.position
			child.player = player

	for exit: RoomExit in get_tree().get_nodes_in_group("exits"):
		exit.player_exited_room.connect(_on_player_exited_room)


func load_new_room(new_room: Room, door_exited: RoomExit, new_room_start_position: Marker2D) -> void:
	toggle_room(current_room, false)

	toggle_room(new_room, true)
	current_room = new_room
	door_last_exited = door_exited
	new_room.player = player
	new_room.setup_player(door_exited, new_room_start_position)


func toggle_room(room: Room, should_be_active: bool) -> void:
	if should_be_active == true:
		room.process_mode = Node.PROCESS_MODE_INHERIT
		#add_child(room)
	else:
		room.process_mode = Node.PROCESS_MODE_DISABLED
		#remove_child(room)
	#room.visible = should_be_active


func _on_player_exited_room(new_room: Room, entry_door: RoomExit, start_position: Marker2D) -> void:
	camera.position = new_room.position
	camera.reset_physics_interpolation()

	load_new_room.call_deferred(new_room, entry_door, start_position)


func _on_key_player_found_key() -> void:
	player.enable_key()


func _on_player_collided_with_spike() -> void:
	var restart_pos = door_last_exited.sister_exit.new_room_start_position as Marker2D
	player.position = restart_pos.global_position
	player.reset_physics_interpolation()
