class_name Level
extends Node2D


@export var camera_transition_duration: float = 0.3
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
	#camera.reset_physics_interpolation()

	player.position = level_start_position.global_position
	player.reset_physics_interpolation()


func _ready() -> void:
	player.player_collided_with_spike.connect(_on_player_collided_with_spike)

	level_exit.player_exiting_level.connect(GameManager._on_player_exiting_level)

	current_room = initial_room
#
	for area: Room in get_tree().get_nodes_in_group("rooms"):
		area.player_exited_room.connect(_on_player_exited_room)


func _process(_delta: float) -> void:
	camera.scale = Vector2(1 / camera.zoom.x, 1 / camera.zoom.y)


func load_new_room(new_room: Room, is_playing_moving_up: bool) -> void:
	if not new_room == current_room:
		previous_room = current_room
		current_room = new_room

	#camera.position = new_room.position
	#camera.reset_physics_interpolation()
	var tween: Tween = self.create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(
			camera, "global_position", current_room.global_position, camera_transition_duration
			).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	if is_playing_moving_up:
		player.velocity = Vector2.UP * initial_player_upwards_velocity


func _on_player_exited_room(new_room: Room, is_player_moving_up: bool) -> void:
	load_new_room.call_deferred(new_room, is_player_moving_up)


func _on_key_player_found_key() -> void:
	player.enable_key()


func _on_player_collided_with_spike() -> void:
	var restart_pos: Marker2D = current_room_restart_position
	player.position = restart_pos.global_position
	player.reset_physics_interpolation()
