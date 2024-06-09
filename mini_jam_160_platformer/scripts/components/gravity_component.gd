class_name GravityComponent
extends Node


@export_subgroup("Settings")
@export var gravity: float = 1000.0
@export var max_fall_speed: float = 300

var is_falling: bool = false


func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta

	is_falling = body.velocity.y > 0 and not body.is_on_floor()

	if is_falling:
		body.velocity.y = clampf(body.velocity.y, 0, max_fall_speed)
