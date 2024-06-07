extends PlatformerState


func _enter() -> void:
	super._enter()
	sprite.play("walk")


#func _exit() -> void:
	#pass


func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		state_changing.emit(self, "jump")


func _update_physics(delta: float) -> void:
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta

	if is_zero_approx(character.velocity.x):
		state_changing.emit(self, "idle")

	super._move(delta, stop_force)
	super._update_physics(delta)
