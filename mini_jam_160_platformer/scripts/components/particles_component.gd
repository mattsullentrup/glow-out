class_name ParticlesComponent
extends Node


@export var sprite: AnimatedSprite2D
@export var particles: GPUParticles2D


func handle_particles(velocity: Vector2) -> void:
	if sprite.is_playing() and sprite.animation == "walk":
		particles.emitting = true
		if velocity.x > 0:
			particles.process_material.emission_shape_offset.x = 1
			particles.process_material.direction.x = -1
		else:
			particles.process_material.emission_shape_offset.x = 16
			particles.process_material.direction.x = 1
	else:
		particles.emitting = false
