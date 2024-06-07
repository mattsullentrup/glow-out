extends PlatformerState


func _enter() -> void:
	super._enter()
	sprite.play("fall")


func _update_physics(delta: float) -> void:
	if character.is_on_floor() and is_zero_approx(character.velocity.y):
		if is_zero_approx(character.velocity.x):
			state_changing.emit(self, "idle")
		else:
			state_changing.emit(self, "move")

	character.velocity += character.get_gravity() * delta

	super._move(delta, 100)
	super._update_physics(delta)
