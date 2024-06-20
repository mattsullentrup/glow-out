class_name Level
extends Node2D


@export var player_starts_facing_left := false
@export var initial_light_amount: int = 30
@export var camera_transition_duration: float = 0.3

@export_category("Nodes")
@export var initial_room: Room
@export var player: Player
@export var level_exit: LevelExit
@export var key: Key
@export var level_start_position: Marker2D
@export var camera: Camera2D

var initial_player_upwards_velocity: float = 350
var current_room: Room
var previous_room: Room

@onready var canvas_modulate: CanvasModulate = $CanvasModulate


func _enter_tree() -> void:
	Globals.play_enter_transition(self)
	camera.position = initial_room.position
	player.position = level_start_position.global_position
	player.reset_physics_interpolation()
	player.light_timer.wait_time = initial_light_amount


func _ready() -> void:
	canvas_modulate.show()
	player.animated_sprite.flip_h = player_starts_facing_left
	key.player_found_key.connect(func() -> void: player.has_key = true)
	current_room = initial_room
	for area: Room in get_tree().get_nodes_in_group("rooms"):
		area.player_exited_room.connect(_on_player_exited_room)


func _process(_delta: float) -> void:
	camera.scale = Vector2(1 / camera.zoom.x, 1 / camera.zoom.y)


func move_to_new_room(new_room: Room, is_playing_moving_up: bool) -> void:
	if not new_room == current_room:
		previous_room = current_room
		current_room = new_room

	var tween: Tween = self.create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(
			camera, "global_position", current_room.global_position, camera_transition_duration
			).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	if is_playing_moving_up:
		player.velocity = Vector2.UP * initial_player_upwards_velocity


func _on_player_exited_room(new_room: Room, is_player_moving_up: bool) -> void:
	move_to_new_room.call_deferred(new_room, is_player_moving_up)
