class_name Player
extends CharacterBody2D


signal player_collided_with_spike

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

@export_subgroup("Values")
@export var initial_light_amount: float = 10

var has_key := false
var spike_tile_coords: Vector2i = Vector2(22, 0)


func _ready() -> void:
	decrease_light()


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
	$PointLight2D.texture_scale = initial_light_amount
	var tween = create_tween()
	tween.tween_property(
			$PointLight2D, "texture_scale", 0.2, light_timer.time_left
			).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).from_current()


func enable_key() -> void:
	has_key = true


func _on_hitbox_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if not body is TileMapLayer:
		return

	var coords = body.get_coords_for_body_rid(body_rid)
	if body.get_cell_atlas_coords(coords) == spike_tile_coords:
		player_collided_with_spike.emit()


func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.animation == "walk" and is_on_floor():
		footstep_sound.pitch_scale = randf_range(0.95, 1.05)
		footstep_sound.play()
