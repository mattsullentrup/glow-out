class_name Player
extends CharacterBody2D


@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent

@export var light_timer: Timer

var has_key := false


func _process(_delta: float) -> void:
	#$PointLight2D.texture_scale = remap(light_timer.time_left, light_timer.wait_time, 0, 3, 0)
	var tween = create_tween()
	tween.tween_property(
			$PointLight2D, "texture_scale", 0, light_timer.time_left
			).set_ease(Tween.EASE_OUT)


func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	animation_component.handle_move_animation(input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input(),
			input_component.get_jump_input_released())
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling)

	move_and_slide()


func enable_key() -> void:
	has_key = true
