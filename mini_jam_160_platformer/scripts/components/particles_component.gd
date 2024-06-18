class_name ParticlesComponent
extends Node


@export var sprite: AnimatedSprite2D
@export var particles: GPUParticles2D


func handle_particles(velocity: Vector2) -> void:
	if not sprite.is_playing() or not sprite.animation == "walk":
		particles.emitting = false
		return

	if particles.process_material is ParticleProcessMaterial:
		particles.emitting = true
		var process_material: ParticleProcessMaterial = particles.process_material
		if velocity.x > 0:
			process_material.emission_shape_offset.x = 1
			process_material.direction.x = -1
		else:
			process_material.emission_shape_offset.x = 16
			process_material.direction.x = 1

