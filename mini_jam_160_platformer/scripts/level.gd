class_name Level
extends Node2D


@export var initial_room: Room
@export var player: Player
@export var level_exit: LevelExit
@export var key: Key
@export var level_start_position: Marker2D
@export var camera: Camera2D

static var current_room: Room

@onready var current_room_restart_position: Marker2D = level_start_position


func _ready() -> void:
	player.position = level_start_position.global_position
	player.reset_physics_interpolation()
	player.player_collided_with_spike.connect(_on_player_collided_with_spike)

	level_exit.player_exiting_level.connect(LevelManager._on_player_exiting_level)

	current_room = initial_room

	for child: Room in get_tree().get_nodes_in_group("rooms"):
		if child != initial_room:
			toggle_room(child, false)
		else:
			camera.position = initial_room.position

	for exit: RoomExit in get_tree().get_nodes_in_group("exits"):
		exit.player_exited_room.connect(_on_player_exited_room)


func load_new_room(new_room: Room, is_playing_moving_up: bool, new_room_start_position: Marker2D) -> void:
	toggle_room(current_room, false)

	toggle_room(new_room, true)
	current_room = new_room
	current_room_restart_position = new_room_start_position
	new_room.setup_player(player, is_playing_moving_up, new_room_start_position)


func toggle_room(room: Room, should_be_active: bool) -> void:
	if should_be_active == true:
		room.process_mode = Node.PROCESS_MODE_INHERIT
		#add_child(room)
	else:
		room.process_mode = Node.PROCESS_MODE_DISABLED
		#remove_child(room)
	#room.visible = should_be_active


func _on_player_exited_room(new_room: Room, is_player_moving_up: bool, start_position: Marker2D) -> void:
	camera.position = new_room.position
	camera.reset_physics_interpolation()

	load_new_room.call_deferred(new_room, is_player_moving_up, start_position)


func _on_key_player_found_key() -> void:
	player.enable_key()


func _on_player_collided_with_spike() -> void:
	var restart_pos = current_room_restart_position
	player.position = restart_pos.global_position
	player.reset_physics_interpolation()
