class_name ParticlesComponent
extends Node


@export var sprite: AnimatedSprite2D
@export var run_particles: GPUParticles2D
@export var landing_particles: GPUParticles2D


func handle_landing_particles() -> void:
	landing_particles.emitting = true


func handle_run_particles(velocity: Vector2) -> void:
	if not sprite.is_playing() or not sprite.animation == "walk":
		run_particles.emitting = false
		return

	if run_particles.process_material is not ParticleProcessMaterial:
		push_error("particle process material is not ParticleProcessMaterial")
		return

	run_particles.emitting = true
	var process_material: ParticleProcessMaterial = run_particles.process_material
	if velocity.x > 0:
		process_material.emission_shape_offset.x = 1
		process_material.direction.x = -1
	else:
		process_material.emission_shape_offset.x = 16
		process_material.direction.x = 1
