extends Area2D


@export var spring_direction: Globals.Directions
@export var force: float = 500


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	var player = body as Player
	#var force: Vector2 = spring_direction * force
	match spring_direction:
		Globals.Directions.NORTH:
			player.velocity.y = -force
		Globals.Directions.SOUTH:
			player.velocity.y = force
		Globals.Directions.EAST:
			player.velocity.x = force
		Globals.Directions.WEST:
			player.velocity.x = -force
		_:
			printerr("Invalid direction")
	$AnimationPlayer.play("spring")
