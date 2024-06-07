extends PlatformerState


var grapple_acceleration_speed = 4
var max_grapple_speed = 1800
var distance: float
var direction: Vector2
var collision_point: Vector2


func _enter() -> void:
	super._enter()
	collision_point = character.gun.get_collision_point()


func _update_physics(delta: float) -> void:
	distance = character.position.distance_to(collision_point)
	direction = character.position.direction_to(collision_point)

	character.velocity = character.velocity.move_toward(
			max_grapple_speed * direction,
			delta * distance * grapple_acceleration_speed
	)

	if Input.is_action_just_released("grapple"):
		state_changing.emit(self, "falling")

	super._update_physics(delta)
