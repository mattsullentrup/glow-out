class_name AdvancedJumpComponent
extends Node


@export_subgroup("Nodes")
@export var jump_buffer_timer: Timer
@export var coyote_timer: Timer

@export_subgroup("Settings")
@export var jump_velocity: float = -350.0
@export_range(0.05, 0.4, 0.01) var coyote_time: float = 0.08

var already_jumped := false
var is_going_up: bool = false
var is_jumping: bool = false
var was_on_floor_last_frame: bool = false


func has_just_landed(body: CharacterBody2D) -> bool:
	return body.is_on_floor() and not was_on_floor_last_frame and is_jumping


func is_allowed_to_jump(body: CharacterBody2D, want_to_jump: bool) -> bool:
	return want_to_jump and (body.is_on_floor() or not coyote_timer.is_stopped())


func handle_jump(body: CharacterBody2D, want_to_jump: bool, jump_released: bool) -> void:
	if has_just_landed(body):
		is_jumping = false

	if is_allowed_to_jump(body, want_to_jump):
		jump(body)

	handle_coyote_time(body)
	handle_jump_buffer(body, want_to_jump)
	handle_variable_jump_height(body, jump_released)

	is_going_up = body.velocity.y < 0 and not body.is_on_floor()
	was_on_floor_last_frame = body.is_on_floor()

	if body.is_on_floor():
		already_jumped = false


func has_just_stepped_off_ledge(body: CharacterBody2D) -> bool:
	return not body.is_on_floor() and was_on_floor_last_frame and not is_jumping


func handle_coyote_time(body: CharacterBody2D) -> void:
	if has_just_stepped_off_ledge(body):
		coyote_timer.start(coyote_time)

	if not coyote_timer.is_stopped() and not is_jumping:
		body.velocity.y = 0


func handle_jump_buffer(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and not body.is_on_floor():
		jump_buffer_timer.start()

	if body.is_on_floor() and not jump_buffer_timer.is_stopped():
		jump(body)


func handle_variable_jump_height(body: CharacterBody2D, jump_released: bool) -> void:
	if already_jumped:
		return

	if jump_released and is_going_up:
		#body.velocity.y = 0
		body.velocity.y = lerpf(body.velocity.y, 0, get_physics_process_delta_time() * 60)
		already_jumped = true


func jump(body: CharacterBody2D) -> void:
	body.velocity.y = jump_velocity
	jump_buffer_timer.stop()
	is_jumping = true
	coyote_timer.stop()
