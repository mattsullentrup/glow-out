class_name AudioComponent
extends Node


@export var animated_sprite: AnimatedSprite2D
@export var footstep_sound: AudioStreamPlayer2D
@export var jump_sound: AudioStreamPlayer2D
@export var landing_sound: AudioStreamPlayer2D

@onready var player: Player = get_owner()


func handle_jump() -> void:
	jump_sound.play()


func handle_landing() -> void:
	landing_sound.play()


func _on_animated_sprite_2d_animation_changed() -> void:
	if animated_sprite.animation == "walk" and player.is_on_floor():
		footstep_sound.pitch_scale = randf_range(0.95, 1.05)
		footstep_sound.play()
