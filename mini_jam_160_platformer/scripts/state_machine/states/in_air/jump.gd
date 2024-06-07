extends PlatformerState


@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

var deacceleration: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


func _enter() -> void:
	super._enter()
	character.velocity.y = jump_velocity
	sprite.play("jump")


#func _exit() -> void:
	#pass


func _update_physics(delta: float) -> void:
	if character.is_on_floor() and is_zero_approx(character.velocity.y):
		if is_zero_approx(character.velocity.x):
			state_changing.emit(self, "idle")
		else:
			state_changing.emit(self, "move")

	character.velocity.y += determine_gravity_force() * delta

	super._move(delta, 500)
	super._update_physics(delta)


func determine_gravity_force() -> float:
	return jump_gravity if character.velocity.y < 0.0 else fall_gravity
