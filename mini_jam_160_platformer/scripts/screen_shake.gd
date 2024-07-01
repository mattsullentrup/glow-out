class_name ScreenShake
extends Node2D


const DECAY_RATE: float = 5
const INTENSITY: float = 30
const INITIAL_STRENGTH: float = 30

var noise_i: float = 0.0
var shake_strength: float = 0.0
var camera: Camera2D

@onready var rng := RandomNumberGenerator.new()
@onready var noise := FastNoiseLite.new()


func _ready() -> void:
	rng.randomize()
	noise.seed = rng.randi()
	noise.frequency = 0.5
	camera = get_viewport().get_camera_2d()
	set_process(false)


func _process(delta: float) -> void:
	#print(is_processing())
	shake_strength = lerpf(shake_strength, 0, DECAY_RATE * delta)
	camera.offset = get_random_offset(delta)

	if is_zero_approx(shake_strength):
		set_process(false)


func get_random_offset(delta: float) -> Vector2:
	noise_i += delta * INTENSITY
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)


func apply_shake() -> void:
	set_process(true)
	shake_strength = INITIAL_STRENGTH
