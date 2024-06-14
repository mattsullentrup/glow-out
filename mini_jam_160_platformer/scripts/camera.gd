extends Camera2D


@export var transition_speed: float = 2


func _physics_process(delta: float) -> void:
	if global_position.is_equal_approx(Level.current_room.global_position):
		return

	var target_pos_x = lerpf(global_position.x, Level.current_room.global_position.x, transition_speed * delta)
	var target_pos_y = lerpf(global_position.y, Level.current_room.global_position.y, transition_speed * delta)

	global_position = Vector2(target_pos_x, target_pos_y)
