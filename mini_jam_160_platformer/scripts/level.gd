class_name Level
extends Node2D


@export var initial_room: Room
@export var player: Player
@export var level_exit: LevelExit
@export var key: Key
@export var level_start_position: Marker2D
@export var camera: Camera2D

static var current_room: Room

var initial_player_upwards_velocity: float = 350
var previous_room: Room

@onready var current_room_restart_position: Marker2D = level_start_position


func _enter_tree() -> void:
	camera.position = initial_room.position
	camera.reset_physics_interpolation()

	player.position = level_start_position.global_position
	player.reset_physics_interpolation()


func _ready() -> void:
	player.player_collided_with_spike.connect(_on_player_collided_with_spike)

	level_exit.player_exiting_level.connect(LevelManager._on_player_exiting_level)

	current_room = initial_room
#
	for area: Area2D in get_tree().get_nodes_in_group("camera_area"):
		area.player_exited_room.connect(_on_player_exited_room)


func load_new_room(new_room: Room, is_playing_moving_up: bool) -> void:
	if not new_room == current_room:
		previous_room = current_room
		current_room = new_room

	camera.position = new_room.position
	camera.reset_physics_interpolation()

	if is_playing_moving_up:
		player.velocity = Vector2.UP * initial_player_upwards_velocity


func _on_player_exited_room(new_room: Room, is_player_moving_up: bool) -> void:
	load_new_room.call_deferred(new_room, is_player_moving_up)


func _on_key_player_found_key() -> void:
	player.enable_key()


func _on_player_collided_with_spike() -> void:
	var restart_pos = current_room_restart_position
	player.position = restart_pos.global_position
	player.reset_physics_interpolation()
