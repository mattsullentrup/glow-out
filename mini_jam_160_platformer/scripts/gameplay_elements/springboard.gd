extends Area2D


var vector_two_directions: Dictionary = {
	0: Vector2.UP,
	45: Vector2(1, -1),
	90: Vector2.RIGHT,
	135: Vector2.ONE,
	180: Vector2.DOWN,
	225: Vector2(-1, 1),
	270: Vector2.LEFT,
	315: -Vector2.ONE
}

var force: float = 450
var spring_direction: Vector2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	initialize_directions()
	animated_sprite.frame = 0


func initialize_directions() -> void:
	var rot: int = roundi(rotation_degrees)
	while rot < 0:
		rot += 360
	var dir: Vector2 = vector_two_directions.get(rot)
	spring_direction = dir


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	var player: Player = body as Player
	var jump_component: AdvancedJumpComponent = player.get_node("AdvancedJumpComponent")
	jump_component.already_jumped = true
	match spring_direction:
		Vector2.UP when player.is_on_floor():
			jump_component.is_jumping = true
			player.velocity = Vector2(player.velocity.x, -force)
		Vector2.UP:
			player.velocity = Vector2(player.velocity.x, -force)
		Vector2.DOWN:
			player.velocity = Vector2(player.velocity.x, force)
		Vector2.RIGHT:
			player.velocity = Vector2(force, player.velocity.y)
		Vector2.LEFT:
			player.velocity = Vector2(-force, player.velocity.y)
		_:
			player.velocity = spring_direction * force

	animation_player.play("spring")
