class_name Key
extends Area2D


signal player_found_key

@onready var key_sound: AudioStreamPlayer = $KeySound
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	key_sound.play()
	sprite_2d.visible = false
	collision_shape.set_deferred("disabled", true)
	player_found_key.emit()
	await key_sound.finished
	queue_free()
