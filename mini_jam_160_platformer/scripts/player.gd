extends CharacterBody2D


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _process(_delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
