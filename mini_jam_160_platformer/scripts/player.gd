class_name Player
extends CharacterBody2D


const INITIAL_LIGHT_SCALE: float = 2.5

#region variables
@export_subgroup("Components")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent
@export var particles_component: ParticlesComponent
@export var audio_component: AudioComponent

@export_subgroup("References")
@export var light_timer: Timer
@export var footstep_sound: AudioStreamPlayer2D
@export var point_light: PointLight2D
@export var death_particles: GPUParticles2D

var has_key := false
var is_alive := true
var spike_tile_coords: Vector2i = Vector2(22, 0)
var room_restart_point: Vector2
var light_tween: Tween
var initial_light_time: int

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var screen_shake: ScreenShake = $ScreenShake
@onready var run_particles: GPUParticles2D = $Particles/RunParticles
@onready var landing_sound: AudioStreamPlayer2D = $SoundFX/LandingSound
@onready var landing_particles: GPUParticles2D = $Particles/LandingParticles
@onready var recharge_sound: AudioStreamPlayer2D = $SoundFX/RechargeSound
#endregion


func _ready() -> void:
	start_decreasing_light()

	jump_component.player_jumped.connect(audio_component.handle_jump)
	jump_component.player_landed.connect(audio_component.handle_landing)
	jump_component.player_landed.connect(particles_component.handle_landing_particles)

	prevent_landing_effects_on_startup()


func _process(_delta: float) -> void:
	var progress_bar: ProgressBar = %RestartProgressBar
	if progress_bar is not ProgressBar:
		return

	progress_bar.value = input_component.time_held

	if input_component.time_held == 0:
		progress_bar.modulate = Color.TRANSPARENT
		return

	progress_bar.modulate = lerp(Color.TRANSPARENT, Color.WHITE, input_component.time_held)


func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input(),
			input_component.get_jump_input_released())
	animation_component.handle_move_animation(input_component.input_horizontal)
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling)
	particles_component.handle_run_particles(velocity)

	move_and_slide()


func prevent_landing_effects_on_startup() -> void:
	var initial_volume: float = landing_sound.volume_db
	landing_sound.volume_db = -80
	landing_particles.hide()
	await get_tree().create_timer(0.5).timeout
	landing_sound.volume_db = initial_volume
	landing_particles.emitting = false
	landing_particles.show()


func start_decreasing_light() -> void:
	light_timer.wait_time = initial_light_time
	if light_tween:
		light_tween.kill()
	light_tween = create_tween()
	light_tween.tween_property(
			point_light, "texture_scale", 0.2, light_timer.time_left
			).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).from(initial_light_time)


func recharge() -> void:
	if light_tween:
		light_tween.kill()
	light_tween = create_tween()
	light_tween.tween_property(
			point_light, "texture_scale", INITIAL_LIGHT_SCALE, 1
			).from_current()

	light_tween.set_parallel()

	recharge_sound.play()
	light_tween.tween_property(recharge_sound, "pitch_scale", 4, 1).from(0.5)
	await light_tween.finished
	recharge_sound.stop()

	start_decreasing_light()


func start_death_routine() -> void:
	is_alive = false
	animated_sprite.hide()
	set_physics_process(false)
	set_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)

	screen_shake.apply_shake()
	audio_component.handle_death()
	death_particles.emitting = true
	await death_particles.finished

	if not room_restart_point:
		push_error("no room restart point")

	var tween: Tween = self.create_tween()
	tween.tween_property(self, "global_position", room_restart_point, 1)
	await tween.finished

	reset_physics_interpolation()
	set_physics_process(true)
	set_process(true)
	$CollisionShape2D.set_deferred("disabled", false)
	$Hitbox/CollisionShape2D.set_deferred("disabled", false)
	animated_sprite.show()
	prevent_landing_effects_on_startup()
	is_alive = true


func check_for_spike_collision(body_rid: RID, body: Node2D) -> void:
		var tile_map: TileMapLayer = body
		var coords: Vector2i = tile_map.get_coords_for_body_rid(body_rid)
		if tile_map.get_cell_atlas_coords(coords) == spike_tile_coords and is_alive:
			start_death_routine()


func _on_hitbox_body_shape_entered(
		body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body is TileMapLayer:
		check_for_spike_collision(body_rid, body)


func _on_level_exit_player_exiting_level() -> void:
	animated_sprite.hide()
	run_particles.hide()
	process_mode = Node.PROCESS_MODE_DISABLED


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "RechargeStation":
		recharge()
