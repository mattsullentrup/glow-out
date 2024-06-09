class_name Player
extends CharacterBody2D


signal player_collided_with_spike

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent
@export var light_timer: Timer

@export_subgroup("Values")
@export var initial_light_amount: float = 30

var has_key := false
var spike_tile_coords: Vector2i = Vector2(22, 0)


func _ready() -> void:
	reset_light()


func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	animation_component.handle_move_animation(input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input(),
			input_component.get_jump_input_released())
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling)

	move_and_slide()


func reset_light() -> void:
	var tween = create_tween()
	tween.tween_property(
			$PointLight2D, "texture_scale", 0, light_timer.time_left
			).set_ease(Tween.EASE_OUT)


func enable_key() -> void:
	has_key = true


func _on_hitbox_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if not body is TileMapLayer:
		return

	var coords = body.get_coords_for_body_rid(body_rid)
	if body.get_cell_atlas_coords(coords) == spike_tile_coords:
		player_collided_with_spike.emit()
