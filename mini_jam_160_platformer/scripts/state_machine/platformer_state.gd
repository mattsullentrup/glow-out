class_name PlatformerState
extends State


var sprite: AnimatedSprite2D
var character: CharacterBody2D

var stop_force: float = 2500
var max_walk_speed: float = 200
var acceleration_speed: float = 1500



func _enter() -> void:
	super._enter()


func _exit() -> void:
	super._exit()


func _handle_input(event) -> void:
	super._handle_input(event)


func _update(_delta: float) -> void:
	pass


func _update_physics(_delta) -> void:
	character.move_and_slide()


func _move(delta: float, deacceleration: float) -> void:
	var direction = Input.get_axis("left", "right")
	if direction:
		character.velocity.x = move_toward(
				character.velocity.x,
				max_walk_speed * direction,
				acceleration_speed * delta
		)
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, deacceleration * delta)
