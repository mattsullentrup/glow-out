class_name Player
extends CharacterBody2D


#signal player_collided_with_spike

@export_subgroup("Components")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent
@export var particles_component: ParticlesComponent

@export_subgroup("References")
@export var light_timer: Timer
@export var footstep_sound: AudioStreamPlayer2D
@export var point_light: PointLight2D

var has_key := false
var spike_tile_coords: Vector2i = Vector2(22, 0)
var room_restart_point: Vector2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	decrease_light()

#func _process(delta: float) -> void:
	#point_light.texture_scale = lerpf(point_light.texture_scale, 0.2, 0.5 * delta)


func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	animation_component.handle_move_animation(input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input(),
			input_component.get_jump_input_released())
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling)
	particles_component.handle_particles(velocity)

	move_and_slide()


func decrease_light() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(
			point_light, "texture_scale", 0.2, light_timer.time_left
			).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)


func start_death_routine() -> void:
	animated_sprite.hide()
	set_physics_process(false)
	set_process(false)

	if not room_restart_point:
		push_error("no room restart point")

	var tween: Tween = self.create_tween()
	tween.tween_property(self, "global_position", room_restart_point, 10)
	await tween.finished

	reset_physics_interpolation()
	set_physics_process(true)
	animated_sprite.show()


func _on_hitbox_body_shape_entered(
		body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body is not TileMapLayer:
		return

	var tile_map: TileMapLayer = body
	var coords: Vector2i = tile_map.get_coords_for_body_rid(body_rid)
	if tile_map.get_cell_atlas_coords(coords) == spike_tile_coords:
		#player_collided_with_spike.emit()
		start_death_routine()


func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite.animation == "walk" and is_on_floor():
		footstep_sound.pitch_scale = randf_range(0.95, 1.05)
		footstep_sound.play()
