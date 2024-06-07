extends PlatformerState


func _enter() -> void:
	super._enter()
	sprite.play("idle")


#func _exit() -> void:
	#pass


func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		state_changing.emit(self, "jump")


func _update_physics(delta: float) -> void:
	if not character.is_on_floor():
		state_changing.emit(self, "falling")

	var direction = Input.get_axis("left", "right")
	if direction:
		state_changing.emit(self, "move")

	super._update_physics(delta)
